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

servers_to_attach.each do |uuid|
  log "  adding slave #{uuid} with ip #{slave_servers[uuid][:ip]} to pgpool"
  # call attach definition
  add_slave_to_pgpool "do attach" do
    guid "ldfkjsldfjdslkfj"
    ip slave_servers[uuid][:ip]
    restart false
  end
end

service "pgpool2" do
  action :restart
end

rightscale_marker :end