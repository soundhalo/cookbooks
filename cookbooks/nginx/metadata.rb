name             'nginx'
maintainer       'Two Bulls'
maintainer_email 'steve@two-bulls.com'
license          'All rights reserved'
description      'Installs/Configures nginx'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports "ubuntu"

depends "rightscale"

recipe "nginx::default", 
  "Installs and configures nginx"

attribute "nginx/haproxy_url",
  :display_name => "haproxy url",
  :description => "url to haproxy server",
  :default => "127.0.0.1"

attribute "nginx/haproxy_port",
  :display_name => "haproxy port",
  :description => "port to haproxy server",
  :default => "80"
  
attribute "nginx/ssl_certificate",
  :display_name => "ssl certificate",
  :description => "the ssl certificate including any chains"

attribute "nginx/ssl_key",
  :display_name => "ssl key",
  :description => "the ssl key"


