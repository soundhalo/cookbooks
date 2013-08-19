rightscale_marker :begin

packages = ['php5','php5-mysql','php5-gd','libapache2-mod-php5','php5-curl']

packages.each do |p|
  package p do
    action :install
  end
end

rightscale_marker :end
