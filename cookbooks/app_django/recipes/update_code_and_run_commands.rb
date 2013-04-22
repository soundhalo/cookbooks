rightscale_marker :begin

# call code update first, this will also do pip install
log "  Updating code"
app "default" do
  destination node[:app][:destination]
  restart false
  action :code_update
end

# run all of the django commands
include_recipe "app_django::run_django_commands"

# restart apache
log "  Reloading apache"
service "apache2" do
  action :reload
  persist false
end

# restart celery
log "  Restarting celery"
service "celeryd" do
  action :restart
  persist false
end

rightscale_marker :end