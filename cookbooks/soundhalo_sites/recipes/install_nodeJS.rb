rightscale_marker :begin

# install node dependancies
packages = ['g++','curl','libssl-dev','apache2-utils','git-core','python-software-properties','python','make']
packages.each do |p|
  package p do
    action :install
  end
end

# add special repo source
execute "add-apt-repository -y ppa:chris-lea/node.js && apt-get update"

package "nodejs" do
  action :install
end

# symlink to node
execute "ln -s /usr/bin/nodejs /usr/bin/node"

rightscale_marker :end