rightscale_marker :begin

if node[:app_django][:is_master]
  log "  Installing crons into tab"
  crons.each do |cron|
    cron "settle_payments" do
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