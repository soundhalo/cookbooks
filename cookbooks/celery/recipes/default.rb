#
# Cookbook Name:: celery
# Recipe:: default
#
# Copyright 2011, Rafael Durán Castañeda
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

rightscale_marker :begin

include_recipe "python"

python_pip "celery" do
  action :install
end

include_recipe "celery::user"

directory "#{node[:celery][:log_dir]}" do
  owner "#{node[:celery][:user]}"
  owner "#{node[:celery][:group]}"
  mode 0755
  action :create
end

directory "#{node[:celery][:run_dir]}" do
  owner "#{node[:celery][:user]}"
  owner "#{node[:celery][:group]}"
  mode 0755
  action :create
end

template "/etc/default/celeryd" do
    source "etc/default/celeryd.erb"
    owner "root"
    group "root"
    mode 0750
end

template "/etc/init.d/celeryd" do
    source "etc/init.d/celeryd.erb"
    owner "root"
    group "root"
    mode 0750
    notifies :restart, "service[celeryd]"
end

# we have to all group writes
log_dir = "/var/log/#{node[:app_django][:app][:name]}"
execute "chmod g+w #{log_dir}/*.log" do
  action :run
  only_if { ::File.exists?("#{log_dir}") }
end

service "celeryd" do
    enabled true
    running true
    supports :restart => true, :reload => true, :status => true
    action [:enable, :start]
end

rightscale_marker :end