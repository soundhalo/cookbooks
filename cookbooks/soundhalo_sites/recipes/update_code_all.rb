rightscale_marker :begin

# Loop through all apps and update code
node[:soundhalo_sites][:app].each do |app_name, entry|
  update_code app_name
end

rightscale_marker :end
