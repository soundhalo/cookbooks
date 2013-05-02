#
# Cookbook Name:: pgpool2
# Recipe:: default
#
# Copyright 2013, Twobulls
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

# register this server
right_link_tag "pgpool2_server:active=true"

package "pgpool2" do
  action :install
end

service "pgpool2" do
  action :enable
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
end

pg_dir = "/etc/pgpool2"

template "#{pg_dir}/pgpool.base.conf" do
  source "pgpool.conf.base.erb"
  owner "root"
  group "root"
  mode "644"
end

directory "#{pg_dir}/servers.d" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
end

template "#{pg_dir}/pcp.conf" do
  source "pgpool2.conf.erb"
  owner "root"
  group "root"
  mode "644"
end

cookbook_file "#{pg_dir}/generate-conf.sh" do
  owner "root"
  group "root"
  mode "0755"
  source "generate-conf.sh"
  cookbook "pgpool2"
end

execute "#{pg_dir}/generate-conf.sh" do
  user "root"
  group "root"
  umask "0077"
  notifies :restart, resources(:service => "pgpool2")
end

rightscale_marker :end