rightscale_marker :begin

# call code update first, this will also do pip install
log "  Updating code"
app "default" do
  destination node[:app][:destination]
  restart false
  action :code_update
end

commands = ['collectstatic --noinput -l']
# if we're the master then sync db and migrate as well
if node[:app_django][:is_master] == "true"
  commands.push('syncdb --noinput','migrate --noinput')
end

log "  Running management commands"
commands.each do |command|
  execute "run python commands" do
    command "#{node[:app_django][:python_bin]} manage.py #{command}"
    user node[:app][:user]
    group node[:app][:group]
    cwd "#{node[:app][:destination]}/"
  end
  log "  command #{command} completed"
end

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