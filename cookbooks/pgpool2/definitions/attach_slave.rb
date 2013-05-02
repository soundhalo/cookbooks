#
# Cookbook Name:: pgpool2
#

define :attach_slave, :server_guid => nil, :server_ip => nil, :server_port => 5432, :restart_pgpool => true do

  log "  Attaching slave #{server_guid} / #{server_ip} / #{server_port}"

  # Creates the directory for vhost server files.
  directory "/etc/pgpool2/servers.d/" do
    owner "root"
    group "root"
    mode "0755"
    recursive true
    action :create
  end

  # (Re)generates the haproxy config file.
  execute "/etc/pgpool2/generate-conf.sh" do
    user "root"
    group "root"
    umask "0077"
    action :nothing
  end
  
  # Creates an individual server file for slave and notifies the concatenation script if necessary.
  template ::File.join("/etc/pgpool2/servers.d/",server_guid) do
    source "pgpool.server.erb"
    owner "root"
    group "root"
    mode "0600"
    backup false
    cookbook "pgpool2"
    variables(
      :server_weight => node[:pgpool2][:read_backend][:weight],
      :server_ip => server_ip,
      :server_port => server_port
    )
    notifies :run, resources(:execute => "/etc/pgpool2/generate-conf.sh")
  end
  
  # check if we should restart
  if restart_pgpool
    service "pgpool2" do
      action :restart
    end
  end
  
end