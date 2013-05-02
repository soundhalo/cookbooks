rightscale_marker :begin

class Chef::Recipe
  include Twobulls::PGPool::Helper
end

log "Attach all slaves"

# get the attached servers
inconfig_servers = get_attached_servers()
log "  Currently attached: #{inconfig_servers.nil? ? 0 : inconfig_servers.count}"

# get all the dbslaves
slave_servers = query_databaseslaves()

# Sends warning if no application servers are found.
log "  No slave servers found" do
  only_if { slave_servers.empty? }
  level :warn
end

# Adds any servers in deployment not in config.
servers_to_attach = Set.new(slave_servers.keys) - inconfig_servers
log "  No slaves to attach" do
  only_if { servers_to_attach.empty? }
end

port = "5432"
pg_dir = "/etc/pgpool2"
server_dir = "#{pg_dir}/servers.d/"

# Creates the directory for vhost server files.
directory "#{server_dir}" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
end

# loop through and add to the file
servers_to_attach.each do |uuid|
  log "  adding slave #{uuid} with ip #{slave_servers[uuid][:ip]} to pgpool"
  
  template ::File.join("#{server_dir}",uuid) do
    source "pgpool.server.erb"
    owner "root"
    group "root"
    mode "0600"
    backup false
    cookbook "pgpool2"
    variables(
      :server_weight => node[:pgpool2][:read_backend][:weight],
      :server_ip => slave_servers[uuid][:ip],
      :server_port => port
    )
  end
  
end

gen_script = "#{pg_dir}/generate-conf.sh"

# (Re)generates the config file.
execute "#{gen_script}" do
  user "root"
  group "root"
  umask "0077"
  action :run
end

service "pgpool2" do
  action :restart
end

rightscale_marker :end