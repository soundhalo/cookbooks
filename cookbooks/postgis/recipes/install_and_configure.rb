#
# Cookbook Name:: postgis
#

rightscale_marker :begin

# GEOS install.
package "geos" do
  action :install
end
log "Installed geos"

package "geos-devel" do
  action :install
end
log "Installed geos-devel"

# proj install.
package "proj" do
  action :install
end
log "Installed proj"

package "proj-devel" do
  action :install
end
log "Installed proj-devel"

# get postgis source code
remote_file "/tmp/#{node[:postgis][:tarball]}" do
 source node[:postgis][:tarball_url]
 mode "0644"
end

log "Retrieved #{node[:postgis][:tarball]} from #{node[:postgis][:tarball_url]}"

pgconfig = ""
case node[:platform]
when "centos", "redhat"
  pgconfig = "/usr/pgsql-9.1/bin/pgconfig"
  log "Configuring for #{node[:platform]}"
end

# compile and install
bash "compile_and_install_postgis" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  tar -zxf #{node[:postgis][:tarball]} -C ~/postgis
  cd postgis
  ./configure --with-pgconfig=#{pgconfig}
  make
  make install
  EOH
end
log "PostGIS installed"

