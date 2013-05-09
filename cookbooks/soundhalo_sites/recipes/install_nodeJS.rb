rightscale_marker :begin

# install node dependancies
packages = ['g++','curl','libssl-dev','apache2-utils','git-core']
packages.each do |p|
  package p do
    action :install
  end
end

directory "#{node[:soundhalo_sites][:web_root]}" do
  action :create
  recursive true
end

bash "install nodejs" do
  flags "-ex"
  code <<-EOH
    cd #{node[:soundhalo_sites][:web_root]}
    git clone git://github.com/ry/node.git node
    cd node
    ./configure
    make
    su -c 'make install'
  EOH
end

rightscale_marker :end