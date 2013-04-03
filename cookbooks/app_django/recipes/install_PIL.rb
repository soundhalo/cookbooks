rightscale_marker :begin

log "  Installing python imaging libraries"

# Install python imaging

case node[:platform]
when "ubuntu"
  execute "apt-get build-dep python-imaging"
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
