
rightscale_marker :begin

pg_dir = "/etc/pgpool2"
server_dir = "#{pg_dir}/servers.d/"
port = "5432"

# Creates the directory for vhost server files.
directory "#{server_dir}" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
end

gen_script = "#{pg_dir}/generate-conf.sh"

# (Re)generates the haproxy config file.
execute "#{gen_script}" do
  user "root"
  group "root"
  umask "0077"
  action :nothing
end

# Creates an individual server file for slave and notifies the concatenation script if necessary.
template ::File.join("#{server_dir}",node[:remote_recipe][:slave_guid]) do
  source "pgpool.server.erb"
  owner "root"
  group "root"
  mode "0600"
  backup false
  cookbook "pgpool2"
  variables(
    :server_weight => node[:pgpool2][:read_backend][:weight],
    :server_ip => node[:remote_recipe][:slave_ip],
    :server_port => port
  )
  notifies :run, resources(:execute => "#{gen_script}")
end

service "pgpool2" do
  action :restart
end

rightscale_marker :end