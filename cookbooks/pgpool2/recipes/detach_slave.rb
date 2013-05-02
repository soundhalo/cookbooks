
rightscale_marker :begin

pg_dir = "/etc/pgpool2"
servers_dir = "#{pg_dir}/servers.d/"
# Creates the directory for vhost server files.
directory "#{servers_dir}" do
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

# Deletes the individual server file and notifies the concatenation script if necessary.
file ::File.join("#{servers_dir}", node[:remote_recipe][:slave_guid]) do
  action :delete
  backup false
  notifies :run, resources(:execute => "#{gen_script}")
end

# restart pgpool
service "pgpool2" do
  action :restart
end

rightscale_marker :end