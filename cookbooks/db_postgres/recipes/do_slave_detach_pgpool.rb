rightscale_marker :begin

class Chef::Resource::RemoteRecipe
  include RightScale::Database::Helper
end

# only detach if this is a slave server
if not node[:db][:this_is_master]
  remote_recipe "detach slave" do
    recipe "pgpool2::detach_slave"
    attributes :dbslave => {
      :slave_uuid => node[:rightscale][:instance_uuid]
    }
    recipients_tags "pgpool2_server:active=true"
  end
end

rightscale_marker :end