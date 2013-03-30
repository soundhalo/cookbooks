#
# Cookbook Name:: celery
# Recipe:: user
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

group "#{node[:celery][:group]}" do
  action :create
end

user "#{node[:celery][:user]}" do
  gid "#{node[:celery][:group]}"
  system true
end

# add our celery user to the web user group
execute "usermod -a -G #{node[:app][:group]} #{node[:celery][:user]}" do
  action :run
end

rightscale_marker :end