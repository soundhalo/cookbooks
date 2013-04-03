rightscale_marker :begin

log "  Installing python imaging libraries"

# Install python imaging
["build-dep","python-imaging"].each |pac| do
  package pac
end

log "  Create symlinks for libraries"

execute "ln -s /usr/lib/`uname -i`-linux-gnu/libfreetype.so /usr/lib/"
execute "ln -s /usr/lib/`uname -i`-linux-gnu/libjpeg.so /usr/lib/"
execute "ln -s /usr/lib/`uname -i`-linux-gnu/libz.so /usr/lib/"

log "  Install PIL"

execute "#{node[:app_django][:pip_bin]} install PIL"

rightscale_marker :end
