rightscale_marker :begin

# setup app and run recipe
update_code "www"

execute "chown -R www-data:www-data #{node[:soundhalo_sites][:app][:www][:web_dir]}/blog/"
execute "chown -R www-data:www-data #{node[:soundhalo_sites][:app][:www][:web_dir]}/support/"

rightscale_marker :end
