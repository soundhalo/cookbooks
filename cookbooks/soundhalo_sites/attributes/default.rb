default[:soundhalo_sites][:apache_port] = 80
default[:soundhalo_sites][:prod_url] = ""
default[:soundhalo_sites][:web_root] = "/home/webapps"
default[:soundhalo_sites][:ssl_path] = "/etc/apache2/certs"

static_vhost = 'static_vhost.erb'

default[:soundhalo_sites][:app][:mobile][:git_repo] = ""
default[:soundhalo_sites][:app][:mobile][:git_branch] = ""
default[:soundhalo_sites][:app][:mobile][:web_url] = ""
default[:soundhalo_sites][:app][:mobile][:use_auth] = 'true'
default[:soundhalo_sites][:app][:mobile][:redirect_non_ios] = 'true'
default[:soundhalo_sites][:app][:mobile][:build_target] = 'production'
set[:soundhalo_sites][:app][:mobile][:template] = static_vhost
set[:soundhalo_sites][:app][:mobile][:use_node] = true

default[:soundhalo_sites][:app][:desktop][:git_repo] = ""
default[:soundhalo_sites][:app][:desktop][:git_branch] = ""
default[:soundhalo_sites][:app][:desktop][:web_url] = ""
default[:soundhalo_sites][:app][:desktop][:use_auth] = 'true'
default[:soundhalo_sites][:app][:desktop][:redirect_non_ios] = 'false'
default[:soundhalo_sites][:app][:desktop][:build_target] = 'production'
set[:soundhalo_sites][:app][:desktop][:template] = static_vhost
set[:soundhalo_sites][:app][:desktop][:use_node] = true

default[:soundhalo_sites][:app][:account][:git_repo] = ""
default[:soundhalo_sites][:app][:account][:git_branch] = ""
default[:soundhalo_sites][:app][:account][:web_url] = ""
default[:soundhalo_sites][:app][:account][:use_auth] = 'true'
default[:soundhalo_sites][:app][:account][:redirect_non_ios] = 'false'
default[:soundhalo_sites][:app][:account][:build_target] = 'production'
set[:soundhalo_sites][:app][:account][:template] = static_vhost
set[:soundhalo_sites][:app][:account][:use_node] = true

default[:soundhalo_sites][:app][:www][:git_repo] = ""
default[:soundhalo_sites][:app][:www][:git_branch] = ""
default[:soundhalo_sites][:app][:www][:web_url] = ""
default[:soundhalo_sites][:app][:www][:use_auth] = 'false'
default[:soundhalo_sites][:app][:www][:redirect_non_ios] = 'false'
set[:soundhalo_sites][:app][:www][:template] = "www_vhost.erb"
set[:soundhalo_sites][:app][:www][:use_node] = false

default[:soundhalo_sites][:app][:partners][:git_repo] = ""
default[:soundhalo_sites][:app][:partners][:git_branch] = ""
default[:soundhalo_sites][:app][:partners][:web_url] = ""
default[:soundhalo_sites][:app][:partners][:use_auth] = 'true'
default[:soundhalo_sites][:app][:partners][:redirect_android] = 'false'
set[:soundhalo_sites][:app][:partners][:template] = "partners_vhost.erb"
set[:soundhalo_sites][:app][:partners][:use_node] = false

node[:soundhalo_sites][:app].each do |app_name, entry|
  set[:soundhalo_sites][:app][app_name][:web_dir] = ::File.join(node[:soundhalo_sites][:web_root],app_name)
  if node[:soundhalo_sites][:app][app_name][:use_node]
    set[:soundhalo_sites][:app][app_name][:git_dir] = ::File.join(node[:soundhalo_sites][:web_root],"#{app_name}.git")
  else
    set[:soundhalo_sites][:app][app_name][:git_dir] = node[:soundhalo_sites][:app][app_name][:web_dir]
  end
end
