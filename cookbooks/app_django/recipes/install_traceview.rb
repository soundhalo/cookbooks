#wget https://www.tracelytics.com/install_tracelytics.sh
#sh ./install_tracelytics.sh [access key]

rightscale_marker :begin

sh_file = "install_tracelytics.sh"

# get client
remote_file "/tmp/#{sh_file}" do
 source "https://www.tracelytics.com/#{sh_file}" 
 mode "0644"
end

# run client
execute "sh /tmp/#{sh_file} #{node[:app_django][:trace_view_key]}"

# install apache library
package "libapache2-mod-oboe" do
  action :install
end

# restart apache
service "apache2" do
  action :reload
  persist false
end

rightscale_marker :end
