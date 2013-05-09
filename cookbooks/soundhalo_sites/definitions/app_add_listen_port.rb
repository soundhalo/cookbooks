define :app_add_listen_port do

  # listens_ports is an array of strings, make sure to compare string to string, not string to integer.
  port_str = params[:name].to_s
  node[:apache][:listen_ports] << port_str unless node[:apache][:listen_ports].include?(port_str)
  log "Apache listen ports: #{node[:apache][:listen_ports].inspect}"

  # Creating pots.conf for apache which will contain all ports apache listen on.
  template "#{node[:apache][:dir]}/ports.conf" do
    cookbook "apache2"
    source "ports.conf.erb"
    variables :apache_listen_ports => node[:apache][:listen_ports]
    notifies :restart, resources(:service => "apache2")
  end

end
