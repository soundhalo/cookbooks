#
# Cookbook Name:: newrelic
# Attributes:: default
#
# Copyright 2012-2013, Escape Studios
#

#############
#BASIC CONFIG
#############
#LICENSE(S)
default['newrelic']['server_monitoring']['license'] = "05184bd48ac541526470ef7b1e1723024b37c4cd"

################
#ADVANCED CONFIG
################
#server monitoring
set['newrelic']['server_monitoring']['logfile'] = nil
set['newrelic']['server_monitoring']['loglevel'] = nil
set['newrelic']['server_monitoring']['proxy'] = nil
set['newrelic']['server_monitoring']['ssl'] = nil
set['newrelic']['server_monitoring']['ssl_ca_bundle'] = nil
set['newrelic']['server_monitoring']['ssl_ca_path'] = nil
set['newrelic']['server_monitoring']['pidfile'] = nil
set['newrelic']['server_monitoring']['collector_host'] = nil
set['newrelic']['server_monitoring']['timeout'] = nil