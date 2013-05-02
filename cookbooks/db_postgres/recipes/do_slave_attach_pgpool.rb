
rightscale_marker :begin

class Chef::Resource::RemoteRecipe
  include RightScale::Database::Helper
end

# only attach if this is a slave server
if not node[:db][:this_is_master]
  remote_recipe "attach slave" do
    recipe "pgpool2::attach_slave"
    attributes :remote_recipe => {
      :slave_ip => get_local_replication_interface,
      :slave_guid => node[:rightscale][:instance_uuid]
    }
    recipients_tags "pgpool2_server:active=true"
  end
end

rightscale_marker :end