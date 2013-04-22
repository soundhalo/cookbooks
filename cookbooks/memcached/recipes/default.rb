#
# Cookbook Name:: memcached
# Recipe:: default
#
# Copyright 2013, Twobulls
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

include_recipe "logrotate"

package "memcached" do
  action :install
end

user "memcache"

template "memcached_config" do
  case node["platform_family"]
  when "rhel"
    path "/etc/sysconfig/memcached"
    source "memcached.sysconfig.erb"
  when "debian"
    path "/etc/memcached.conf"
    source "memcached.conf.erb"
  end

  mode "0644"
  variables(
    :listen           => node["memcached"]["listen"],
    :port             => node["memcached"]["port"],
    :max_memory       => node["memcached"]["max_memory"],
    :max_connections  => node["memcached"]["max_connections"],
    :log_file         => node["memcached"]["log_file"],
    :user             => node["memcached"]["user"],
    :verbose          => node["memcached"]["verbose"]
  )
  notifies :restart, "service[memcached]", :immediately
end

logrotate_app "memcached" do
  cookbook "logrotate"
  path node["memcached"]["log_file"]
  frequency "daily"
  rotate 7
  create "644 root root"
  only_if { node["platform_family"] == "debian" }
end

service "memcached" do
  supports :status => true, :start => true, :stop => true, :restart => true
  action [:enable, :start]
end

rightscale_marker :end