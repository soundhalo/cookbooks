
rightscale_marker :begin

service "rsyslog" do
  supports :reload => true, :restart => true, :status => true, :start => true, :stop => true
  action :nothing
end

# setup entry in rsyslog
template "/etc/rsyslog.d/49-haproxy.conf" do
  only_if { node[:platform] == "ubuntu" }
  source "haproxy_rsyslog.erb"
  cookbook "lb_haproxy"
  owner "root"
  notifies :restart, resources(:service => "rsyslog")
end

# setup logrotation
template "/etc/logrotate.d/haproxy" do
  only_if { node[:platform] == "ubuntu" }
  source "haproxy_logrotate.erb"
  cookbook "lb_haproxy"
  owner "root"
end

rightscale_marker :end
