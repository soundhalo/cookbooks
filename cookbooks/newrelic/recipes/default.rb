#
# Cookbook Name:: newrelic
# Recipe:: default
#
# Copyright 2013, Twobulls
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

include_recipe "newrelic::install"
include_recipe "newrelic::server-monitor"

rightscale_marker :end
