#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2013, Two Bulls
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

package "nginx" do
  action :install
end

service "nginx" do
  action :nothing
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
end

template "/etc/nginx/sites-available/default" do
  source "default.conf.erb"
  owner "root"
  group "root"
  mode "644"
end

# add ssl certificates
cert_folder = "/etc/nginx/certs"

directory node[:nginx][:ssl_path] do
  recursive true
end

template "#{node[:nginx][:ssl_path]}/ssl_cert.crt" do
  source "ssl_cert.crt.erb"
  owner "root"
  group "root"
  mode "644"
end

template "#{node[:nginx][:ssl_path]}/ssl_key.pem" do
  source "ssl_key.pem.erb"
  owner "root"
  group "root"
  mode "644"
end

service "nginx" do
  action [:enable, :start]
end

rightscale_marker :end
