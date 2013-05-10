rightscale_marker :begin

include_recipe "repo::default"

# setup app and run recipe
update_code "desktop"

rightscale_marker :end
