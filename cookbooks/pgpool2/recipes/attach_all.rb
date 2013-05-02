rightscale_marker :begin

class Chef::Recipe
  include Twobulls::PGPool::Helper
end

log "Attach all for [#{pool_name}]"
# Obtains current list from lb config file.
# See cookbooks/lb/libraries/helper.rb for the "get_attached_servers" method.
inconfig_servers = get_attached_servers(pool_name)
log "  Currently attached: #{inconfig_servers.nil? ? 0 : inconfig_servers.count}"

# Obtains list of app servers in deployment.
# See cookbooks/lb/libraries/helper.rb for the "query_appservers" method.
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

servers_to_attach.each do |uuid|
  # call attach definition
  attach_slave "attach" do
    server_guid uuid
    server_ip slave_servers[uuid][:ip]
    restart_pgpool false
  end
end

service "pgpool2" do
  action :restart
end

rightscale_marker :end