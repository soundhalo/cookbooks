#
# Cookbook Name:: celery
# Recipe:: do_stop

log "  Running celery stop"
service "celeryd" do
  action :stop
  persist false
end
