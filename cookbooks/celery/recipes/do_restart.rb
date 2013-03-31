#
# Cookbook Name:: celery
# Recipe:: do_restart

log "  Running celery restart"
service "celeryd" do
  action :restart
  persist false
end
