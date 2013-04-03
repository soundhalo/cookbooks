rightscale_marker :begin

log "  Installing python imaging libraries"

# Install python imaging
imaging_packages = ["python-imaging","libjpeg-dev","libfreetype6","libfreetype6-dev","zlib1g-dev"]

if node[:platform] ~= "ubuntu"
  imaging_packages.each do |pack| 
    package pack
  end
else
  raise "this script only works with ubuntu, exiting "
end

log "  Create symlinks for libraries"

execute "ln -s /usr/lib/`uname -i`-linux-gnu/libfreetype.so /usr/lib/"
execute "ln -s /usr/lib/`uname -i`-linux-gnu/libjpeg.so /usr/lib/"
execute "ln -s /usr/lib/`uname -i`-linux-gnu/libz.so /usr/lib/"

log "  Install PIL"

execute "#{node[:app_django][:pip_bin]} install PIL"

rightscale_marker :end
