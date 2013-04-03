rightscale_marker :begin

log "  Installing python imaging libraries"

# Install python imaging
package "build-dep" do
  action :install
end

package "python-imaging" do 
  action :install
end

log "  Create symlinks for libraries"

execute "ln -s /usr/lib/`uname -i`-linux-gnu/libfreetype.so /usr/lib/"
execute "ln -s /usr/lib/`uname -i`-linux-gnu/libjpeg.so /usr/lib/"
execute "ln -s /usr/lib/`uname -i`-linux-gnu/libz.so /usr/lib/"

log "  Install PIL"

execute "#{node[:app_django][:pip_bin]} install PIL"

rightscale_marker :end
