#wget https://www.tracelytics.com/install_tracelytics.sh
#sh ./install_tracelytics.sh [access key]
sh_file = "install_tracelytics.sh"

remote_file "/tmp/#{sh_file}}" do
 source "https://www.tracelytics.com/#{sh_file}" 
 mode "0644"
end

execute "sh /tmp/#{sh_file} #{node[:app_django][:trace_view_key]}"