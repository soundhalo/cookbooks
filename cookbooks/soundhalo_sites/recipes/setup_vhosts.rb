
rightscale_marker :begin

include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_ssl"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"

# Disable default vhost
# See https://github.com/rightscale/cookbooks/blob/master/apache2/definitions/apache_site.rb for the "apache_site" definition.
apache_site "000-default" do
  enable false
end

the_port = node[:soundhalo_sites][:apache_port]
# Adds php port to list of ports for webserver to listen on
# See cookbooks/app/definitions/app_add_listen_port.rb for the "app_add_listen_port" definition.
app_add_listen_port the_port

# Loop through all apps and create vhosts
node[:soundhalo_sites][:app].each do |app_name, entry|
  
  # Configure apache vhost for mobile web
  web_app app_name do
    template "static_vhost.erb"
    docroot "#{entry[:web_dir]}/#{app_name}"
    webroot entry[:web_dir]
    vhost_port the_port.to_s
    server_name entry[:web_url]
    use_auth node[:soundhalo_sites][:use_auth]
    prod_url node[:soundhalo_sites][:prod_url]
    cookbook "soundhalo_sites"
  end

end

rightscale_marker :end
