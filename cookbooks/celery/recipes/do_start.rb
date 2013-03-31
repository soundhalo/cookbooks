#
# Cookbook Name:: celery
# Recipe:: do_start

log "  Running celery start"
service "celeryd" do
  action :start
  persist false
end
