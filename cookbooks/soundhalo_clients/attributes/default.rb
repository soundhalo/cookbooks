default[:soundhalo_clients][:ip] = node[:cloud][:private_ips][0]
default[:soundhalo_clients][:apache_port] = 8000
default[:soundhalo_clients][:prod_url] = ""
default[:soundhalo_clients][:web_root] = "/home/webapps"

static_vhost = 'static_vhost.erb'

default[:soundhalo_clients][:app][:mobile][:git_repo] = ""
default[:soundhalo_clients][:app][:mobile][:git_branch] = ""
default[:soundhalo_clients][:app][:mobile][:web_url] = ""
default[:soundhalo_clients][:app][:mobile][:use_auth] = 'true'
default[:soundhalo_clients][:app][:mobile][:build_target] = 'production'
set[:soundhalo_clients][:app][:mobile][:template] = static_vhost
set[:soundhalo_clients][:app][:mobile][:use_node] = true

default[:soundhalo_clients][:app][:desktop][:git_repo] = ""
default[:soundhalo_clients][:app][:desktop][:git_branch] = ""
default[:soundhalo_clients][:app][:desktop][:web_url] = ""
default[:soundhalo_clients][:app][:desktop][:use_auth] = 'true'
default[:soundhalo_clients][:app][:desktop][:build_target] = 'production'
set[:soundhalo_clients][:app][:desktop][:template] = static_vhost
set[:soundhalo_clients][:app][:desktop][:use_node] = true

node[:soundhalo_clients][:app].each do |app_name, entry|
  set[:soundhalo_clients][:app][app_name][:web_dir] = ::File.join(node[:soundhalo_clients][:web_root],app_name)
  if node[:soundhalo_clients][:app][app_name][:use_node]
    set[:soundhalo_clients][:app][app_name][:git_dir] = ::File.join(node[:soundhalo_clients][:web_root],"#{app_name}.git")
  else
    set[:soundhalo_clients][:app][app_name][:git_dir] = node[:soundhalo_clients][:app][app_name][:web_dir]
  end
end
