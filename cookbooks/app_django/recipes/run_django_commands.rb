rightscale_marker :begin

commands = []
# if we're the master then sync db and migrate as well
if node[:app_django][:is_master] == "true"
  commands.push('syncdb --noinput','migrate --noinput')
end
commands.push('collectstatic --noinput -l')

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


rightscale_marker :end