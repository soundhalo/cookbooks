#
# Cookbook Name:: soundhalo_sites
# Recipe:: default
#
# Copyright 2013, Twobulls
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

node[:soundhalo_sites][:app].each do |app_name, entry|
  node[:soundhalo_sites][:app][app_name][:web_dir] = ::File.join(node[:soundhalo_sites][:web_root],app_name)
  node[:soundhalo_sites][:app][app_name][:git_dir] = ::File.join(node[:soundhalo_sites][:web_root],app_name,".git")
end

directory "#{node[:soundhalo_sites][:web_root]}" do
  action :create
  recursive true
end

rightscale_marker :end
