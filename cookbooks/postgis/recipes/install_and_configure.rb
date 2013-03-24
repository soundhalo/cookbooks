#
# Cookbook Name:: postgis
#

rightscale_marker :begin

# GEOS install.
package "geos" do
  action :install
end
package "geos-devel" do
  action :install
end

# proj install.
package "proj" do
  action :install
end
package "proj-devel" do
  action :install
end

# get postgis source code
remote_file "/tmp/#{node[:postgis][:tarball]}" do
 source node[:postgis][:tarball_url]
 mode "0644"
end

case node[:platform]
when "centos", "redhat"
  pgconfig = "/usr/pgsql-9.1/bin/pgconfig"
end

# compile and install
bash "compile_and_install_postgis" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  tar -zxf #{node[:postgis][:tarball]}
  cd #{node[:postgis][:tarball]}
  ./configure --with-pgconfig=#{pgconfig}
  make
  make install
  EOH
end

