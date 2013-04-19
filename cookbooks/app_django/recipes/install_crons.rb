rightscale_marker :begin

if node[:app_django][:is_master] == "true"
  log "  Installing crons into tab"
  node[:app_django][:crons].each do |cron|
    cron cron[:command] do
      command "#{node[:app_django][:python_bin]} #{node[:app][:destination]}/manage.py #{cron[:command]}"
      minute cron[:minute]
      hour cron[:hour]
      action :create
    end
    log "  cron #{cron[:command]} installed!"
  end

  log "  All crons installed"
else
  log "  Skipping cron tab install as not master"
end

rightscale_marker :end