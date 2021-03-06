
rightscale_marker :begin

include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"

# Disable default vhost
# See https://github.com/rightscale/cookbooks/blob/master/apache2/definitions/apache_site.rb for the "apache_site" definition.
apache_site "000-default" do
  enable false
end

the_port = node[:soundhalo_clients][:apache_port]
# Adds php port to list of ports for webserver to listen on
# See cookbooks/app/definitions/app_add_listen_port.rb for the "app_add_listen_port" definition.
app_add_listen_port the_port

# Loop through all apps and create vhosts
node[:soundhalo_clients][:app].each do |app_name, entry|
  
  # Configure apache vhost 
  web_app app_name do
    template entry[:template]
    docroot "#{entry[:web_dir]}/#{app_name}"
    webroot entry[:web_dir]
    vhost_port the_port.to_s
    server_name entry[:web_url]
    use_auth entry[:use_auth]
    prod_url node[:soundhalo_clients][:prod_url]
    cookbook "soundhalo_clients"
  end

end

# enable special empty vhost to allow
# load balancer health checks when
# http auth is being used
apache_site "000-empty" do
  enable true
end

rightscale_marker :end
