define :update_code do
  
  app_name = params[:name]
  
  log "  Starting code update sequence for #{app_name}"
  log "  Current project git root is set to #{node[:soundhalo_sites][:app][app_name][:git_dir]}"
  log "  Downloading project repo"

  repo "default" do
    destination node[:soundhalo_sites][:app][app_name][:git_dir]
    action :pull
    app_user "www-data"
    repository node[:soundhalo_sites][:app][app_name][:git_repo]
    revision node[:soundhalo_sites][:app][app_name][:git_branch]
    persist false
  end

  log "  Running build script"

  bash "run build script" do
    flags "-ex"
    code <<-EOH
      cd #{node[:soundhalo_sites][:app][app_name][:git_dir]}
      ./scripts/build.sh #{app_name} production #{node[:soundhalo_sites][:app][app_name][:web_dir]}
    EOH
  end

  # Restarting apache
  service "apache2" do
    action :reload
  end
  
end