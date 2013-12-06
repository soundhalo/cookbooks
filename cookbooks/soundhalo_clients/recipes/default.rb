#
# Cookbook Name:: soundhalo_clients
# Recipe:: default
#
# Copyright 2013, Twobulls
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

directory "#{node[:soundhalo_clients][:web_root]}" do
  action :create
  recursive true
end

node[:soundhalo_clients][:app].each do |app_name, entry|
  
  directory "#{node[:soundhalo_clients][:app][app_name][:web_dir]}" do
    owner "root"
    group "root"
    recursive true
    action :create
  end
  
end

# set private ip
node[:soundhalo_clients][:ip] = node[:cloud][:private_ips][0]

log "  Application IP is #{node[:soundhalo_clients][:ip]}"
log "  Application port is #{node[:soundhalo_clients][:port]}"

right_link_tag "appserver:active=true"
right_link_tag "appserver:listen_ip=#{node[:soundhalo_clients][:ip]}"
right_link_tag "appserver:listen_port=#{node[:soundhalo_clients][:apache_port]}"

# create the htpasswd file
template ::File.join(node[:soundhalo_clients][:web_root],"htpasswd") do
  source "htpasswd.erb"
  mode "0644"
end

# create empty vhost
template "/etc/apache2/sites-available/000-empty" do
  source "000-empty.erb"
  mode "0644"
end

rightscale_marker :end
