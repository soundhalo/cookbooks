
rightscale_marker :begin

#should only be called by database server
add_slave_to_pgpool "do attach" do
  guid node[:remote_recipe][:slave_guid]
  ip node[:remote_recipe][:slave_ip]
end

rightscale_marker :end