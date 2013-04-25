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
default['newrelic']['server_monitoring']['license'] = "CHANGE_ME"

################
#ADVANCED CONFIG
################
#server monitoring
default['newrelic']['server_monitoring']['logfile'] = nil
default['newrelic']['server_monitoring']['loglevel'] = nil
default['newrelic']['server_monitoring']['proxy'] = nil
default['newrelic']['server_monitoring']['ssl'] = nil
default['newrelic']['server_monitoring']['ssl_ca_bundle'] = nil
default['newrelic']['server_monitoring']['ssl_ca_path'] = nil
default['newrelic']['server_monitoring']['pidfile'] = nil
default['newrelic']['server_monitoring']['collector_host'] = nil
default['newrelic']['server_monitoring']['timeout'] = nil