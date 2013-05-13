default[:soundhalo_sites][:apache_port] = 80
default[:soundhalo_sites][:prod_url] = ""
default[:soundhalo_sites][:web_root] = "/home/webapps"

default[:soundhalo_sites][:app][:mobile][:git_repo] = ""
default[:soundhalo_sites][:app][:mobile][:git_branch] = ""
default[:soundhalo_sites][:app][:mobile][:web_url] = ""
default[:soundhalo_sites][:app][:mobile][:use_auth] = 'true'

set[:soundhalo_sites][:app][:mobile][:web_dir] = ""
set[:soundhalo_sites][:app][:mobile][:git_dir] = ""

default[:soundhalo_sites][:app][:desktop][:git_repo] = ""
default[:soundhalo_sites][:app][:desktop][:git_branch] = ""
default[:soundhalo_sites][:app][:desktop][:web_url] = ""
default[:soundhalo_sites][:app][:desktop][:use_auth] = 'false'
set[:soundhalo_sites][:app][:desktop][:web_dir] = ""
set[:soundhalo_sites][:app][:desktop][:git_dir] = ""

node[:soundhalo_sites][:app].each do |app_name, entry|
  set[:soundhalo_sites][:app][app_name][:web_dir] = ::File.join(node[:soundhalo_sites][:web_root],app_name)
  set[:soundhalo_sites][:app][app_name][:git_dir] = ::File.join(node[:soundhalo_sites][:web_root],"#{app_name}.git")
end
