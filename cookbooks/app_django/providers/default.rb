#
# Cookbook Name:: app_django
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

# Stop apache
action :stop do
  log "  Running stop sequence"
  service "apache2" do
    action :stop
    persist false
  end
end

# Start apache
action :start do
  log "  Running start sequence"
  service "apache2" do
    action :start
    persist false
  end
end

# Reload apache
action :reload do
  log "  Running reload sequence"
  service "apache2" do
    action :reload
    persist false
  end
end

# Restart apache
action :restart do
  log "  Running restart sequence"
  # Calls the :stop action.
  action_stop
  sleep 5
  # Calls the :start action.
  action_start
end

action :install do
  # Installing required packages
  packages = new_resource.packages
  log "  Packages which will be installed: #{packages}"

  packages.each do |p|
    package p
  end

  # Link python-pip to default pip in system bin path - required by app server
  link "#{node[:app_django][:pip_bin]}" do
    to "/usr/bin/pip-python"
    not_if { ::File.exists?("#{node[:app_django][:pip_bin]}") }
  end

  log "  Module dependencies which will be installed: #{node[:app][:module_dependencies]}"
  # Installing python modules dependencies
  node[:app][:module_dependencies].each do |mod|
    # See https://github.com/rightscale/cookbooks/blob/master/apache2/definitions/apache_module.rb for the "apache_module" definition.
    apache_module mod
  end

  # Install Django 1.4
  # See https://github.com/rightscale/cookbooks/blob/master/python/resources/pip.rb for the "python_pip" resource.  
  python_pip "django" do
    version "#{node[:app_django][:version]}"
    action :install
  end

  # Install specified python packages

  # Variable node[:app_django][:project][:opt_pip_list] contains space separated list of Python packages along
  # with their versions in the format:
  #
  #   py-pkg1==version  py-pkg2==version py-pkg3==version
  #
  log "  Installing user specified python packages:"
  pip_list = node[:app_django][:project][:opt_pip_list]
  # Split pip_list into an array
  pip_list = pip_list.split
  # Installing python packages
  pip_list.each do |pip_name|
    python_pip pip_name do
      action :install
    end
  end unless pip_list.empty?

end

# Setup apache PHP virtual host
action :setup_vhost do

  project_root = new_resource.destination
  django_port = new_resource.port

  # Disable default vhost
  log "  Unlinking default apache vhost"
  # See https://github.com/rightscale/cookbooks/blob/master/apache2/definitions/apache_site.rb for the "apache_site" definition.
  apache_site "000-default" do
    enable false
  end

  # Adds django port to list of ports for webserver to listen on
  # See cookbooks/app/definitions/app_add_listen_port.rb for the "app_add_listen_port" definition.
  app_add_listen_port django_port

  # Configure apache vhost for Django
  log "  Creating apache.vhost"
  # See https://github.com/rightscale/cookbooks/blob/master/apache2/definitions/web_app.rb for the "web_app" definition. 
  web_app "http-#{django_port}-#{node[:web_apache][:server_name]}.vhost" do
    template "apache_mod_wsgi_vhost.erb"
    approot project_root
    docroot project_root + "/" + node[:app_django][:app][:name]
    wsgi_group node[:web_apache][:wsgi_group]
    wsgi_threads node[:web_apache][:wsgi_threads]
    wsgi_processes node[:web_apache][:wsgi_processes]
    vhost_port django_port.to_s
    server_name node[:web_apache][:server_name]
    allow_override node[:web_apache][:allow_override]
    apache_log_dir node[:apache][:log_dir]
    apache_serve_local_files node[:app_django][:apache][:serve_local_files]
    cookbook "app_django"
  end

end

# Setup Django Database Connection
action :setup_db_connection do

  project_root = new_resource.destination
  db_name = new_resource.database_name

  # Moves django default settings file to settings_default and create settings.py from django template
  settingsfile = ::File.expand_path(::File.join(project_root, "local_settings.py"))
  defaultfile = ::File.expand_path(::File.join(project_root, "local_settings_default.py"))
  ruby_block "move django settings" do
    only_if { ::File.exists?(settingsfile) }
    not_if { ::File.exists?(defaultfile) }
    block do
      require 'fileutils'
      FileUtils.mv(settingsfile, defaultfile)
    end
  end
  
  # celery broker 
  broker_url = "amqp://" +  node[:app_django][:celery][:broker_user]
  broker_url += ":" + node[:app_django][:celery][:broker_password]
  broker_url += "@" + node[:app_django][:celery][:broker_host]
  broker_url += ":" + node[:app_django][:celery][:broker_port]
  broker_url += "/" + node[:app_django][:celery][:broker_vhost]
  log " Setting up broker_url: #{broker_url}"
  
  # Tells selected db_adapter to fill in it's specific connection template
  log "  Creating local_settings.py for DB: #{db_name}"
  # See cookbooks/db/definitions/db_connect_app.rb for the "db_connect_app" definition.
  db_connect_app "#{project_root}/#{node[:app_django][:app][:name]}/local_settings.py" do
    template "local_settings.py.erb"
    owner node[:app][:user]
    group node[:app][:group]
    database db_name
    cookbook "app_django"
    driver_type "python"
    vars(
      :broker_url => broker_url
    )
  end

  log "  Creating local_environment.py"
  template "#{project_root}/#{node[:app_django][:app][:name]}/local_environment.py" do
    action :create
    source "local_environment.py.erb"
    group "#{node[:app][:group]}"
    owner "#{node[:app][:user]}"
    mode "0644"
    cookbook 'app_django'
    variables(
      :environment => node[:app_django][:app][:environment]
    )
  end
  
  # setup log files folder
  directory "/var/log/#{node[:app_django][:app][:name]}" do
    owner "#{node[:app][:user]}"
    group "#{node[:app][:group]}"
    mode "0755"
    action :create
  end
  
  log "  Creating local_logfiles.py"
  template "#{project_root}/#{node[:app_django][:app][:name]}/local_logfiles.py" do
    action :create
    source "local_logfiles.py.erb"
    group "#{node[:app][:group]}"
    owner "#{node[:app][:user]}"
    cookbook 'app_django'
    mode "0644"
    variables(
      :environement => node[:app_django][:app][:environment]
    )
  end

end

# Download/Update application repository
action :code_update do

  deploy_dir = new_resource.destination

  log "  Starting code update sequence"
  log "  Current project doc root is set to #{deploy_dir}"
  log "  Downloading project repo"

  # Calling "repo" LWRP to download remote project repository
  # See cookbooks/repo/resources/default.rb for the "repo" resource.
  log " The user context for git is: #{node[:app][:user]}"
  repo "default" do
    destination deploy_dir
    action node[:repo][:default][:perform_action].to_sym
    app_user node[:app][:user]
    repository node[:repo][:default][:repository]
    persist false
  end

  # Installing python packages using requirements.txt
  #
  # If the checked application contains a requirements.txt, then we can install all
  # the required python packages using "pip install" command.
  #
  log "  pip will install python packages from requirements.txt"
  # Installing python packages from {deploy_dir}/requirements.txt if it exists
  execute "#{node[:app_django][:pip_bin]} install --requirement=#{deploy_dir}/requirements.txt" do
    only_if { ::File.exists?("#{deploy_dir}/requirements.txt") }
  end

  # Restarting apache
  # Calls the :restart action.
  action_restart

end

# Set monitoring tools for Django application. Not implemented.
action :setup_monitoring do
  log "Monitoring resource is not implemented in django framework yet. Use apache monitoring instead."
end
