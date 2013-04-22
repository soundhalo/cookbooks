name             'memcached'
maintainer       'Two Bulls'
maintainer_email 'steve@two-bulls.com'
license          'All rights reserved'
description      'Installs/Configures memcached'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "logrotate"

%w{ centos redhat ubuntu }.each do |os|
    supports os
end

recipe "memcached::default",
  "Installs and configures memcached"
  
attribute "memcached/port",
  :display_name => "memcached port",
  :description =>
    "port",
  :required => "optional",
  :default => "11211",
  :recipes => ["memcached::default"]  
  
attribute "memcached/listen",
  :display_name => "memcached url",
  :description =>
    "url",
  :required => "optional",
  :default => "127.0.0.1",
  :recipes => ["memcached::default"]
  
attribute "memcached/max_memory",
  :display_name => "memcached maximum memory",
  :description =>
    "in MB",
  :required => "optional",
  :default => "640",
  :recipes => ["memcached::default"]
  