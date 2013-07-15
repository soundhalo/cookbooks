rightscale_marker :begin

template "/etc/logrotate.d/celeryd" do
    source "celeryd.erb"
    owner "root"
    group "root"
    mode 0644
end

rightscale_marker :end