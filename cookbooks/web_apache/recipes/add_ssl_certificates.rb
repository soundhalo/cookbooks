rightscale_marker :begin

package "mod_ssl" do
  not_if { node[:platform].include? "ubuntu" }
end

ssl_dir = "/etc/#{node[:web_apache][:config_subdir]}/ssl"

# Creating directory where certificate files will be stored
directory ssl_dir do
  mode "0700"
  recursive true
end

ssl_certificate_file = ::File.join(ssl_dir, "#{node[:web_apache][:server_name]}.crt")
ssl_key_file = ::File.join(ssl_dir, "#{node[:web_apache][:server_name]}.key")
ssl_certificate_chain_file = ::File.join(ssl_dir, "gd_bundle.crt")

# Updating crt file config
template ssl_certificate_file do
  mode "0400"
  source "ssl_certificate.erb"
end

# Updating key file config
template ssl_key_file do
  mode "0400"
  source "ssl_key.erb"
end

template "#{ssl_certificate_chain_file}" do
  mode "0400"
  source "ssl_certificate_chain.erb"
end

