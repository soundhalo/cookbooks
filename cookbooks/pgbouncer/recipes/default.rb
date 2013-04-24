#
# Cookbook Name:: pgbouncer
# Recipe:: default
#
# Copyright 2013, Twobulls
#
# All rights reserved - Do Not Redistribute
#
rightscale_marker :begin

package "pgbouncer" do
  action :upgrade
end

service "pgbouncer" do
  action :nothing
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
end

template "/etc/pgbouncer/pgbouncer.ini" do
  source "pgbouncer.ini.erb"
  owner "root"
  group "root"
  mode "644"
end

template "/etc/pgbouncer/userlist.txt" do
  source "userlist.txt.erb"
  owner "root"
  group "root"
  mode "644"
end

template "/etc/default/pgbouncer" do
  source "pgbouncer.default.erb"
  owner "root"
  group "root"
  mode "644"
end

service "pgbouncer" do
  action [:enable, :start]
end

rightscale_marker :end
