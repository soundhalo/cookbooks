rightscale_marker :begin

# Loop through all apps and update code
node[:soundhalo_sites][:app].each do |app_name, entry|
  update_code "code" do
    app_name app_name
  end
end

rightscale_marker :end
