#
# Cookbook Name:: soundhalo_sites
# Recipe:: default
#
# Copyright 2013, Twobulls
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

directory "#{node[:soundhalo_sites][:web_root]}" do
  action :create
  recursive true
end

node[:soundhalo_sites][:app].each do |app_name, entry|
  
  directory "#{node[:soundhalo_sites][:app][app_name][:web_dir]}" do
    owner "root"
    group "root"
    recursive true
    action :create
  end
  
end

# create the htpasswd file
template ::File.join(node[:soundhalo_sites][:web_root],"htpasswd") do
  source "htpasswd.erb"
  mode "0644"
end

rightscale_marker :end
