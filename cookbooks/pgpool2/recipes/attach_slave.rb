
rightscale_marker :begin

#should only be called by database server
add_slave_to_pgpool "do attach" do
  server_guid node[:dbslave][:slave_guid]
  server_ip node[:dbslave][:slave_ip]
  restart_pgpool true
end

rightscale_marker :end