maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "Installs/Configures lb_haproxy"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "13.3.0"

# supports "centos", "~> 5.8", "~> 6"
# supports "redhat", "~> 5.8"
# supports "ubuntu", "~> 10.04", "~> 12.04"

depends "rightscale"
depends "app"
depends "lb"

recipe "lb_haproxy::setup_server",
  "This loads the required 'lb' resource using the HAProxy provider."

recipe "lb_haproxy::enable_rsyslog",
  "Enables rsyslog to listen for haproxy and sets up appropriate logrotations."

attribute "lb_haproxy/algorithm",
  :display_name => "Load Balancing Algorithm",
  :description =>
    "The algorithm that the load balancer will use to direct traffic." +
    " Example: roundrobin",
  :required => "optional",
  :default => "roundrobin",
  :choice => ["roundrobin", "leastconn", "source"],
  :recipes => [
    "lb_haproxy::setup_server"
  ]

attribute "lb_haproxy/timeout_server",
  :display_name => "Server Timeout",
  :description =>
    "The maximum inactivity time on the server side to direct traffic." +
    " Example: 60000",
  :required => "optional",
  :default => "60000",
  :recipes => [
    "lb_haproxy::setup_server"
  ]

attribute "lb_haproxy/timeout_client",
  :display_name => "Client Timeout",
  :description =>
    "The maximum inactivity time on the client side in milliseconds." +
    " Example: 60000",
  :required => "optional",
  :default => "60000",
  :recipes => [
    "lb_haproxy::setup_server"
  ]

attribute "lb_haproxy/ssl",
  :display_name => "Supports ssl tcp forwarding",
  :description =>
    "Whether this loadbalancer supports tcp ssl forwarding to default lb.",
  :required => "optional",
  :default => "true",
  :choice => ["true","false"],
  :recipes => [
    "lb_haproxy::setup_server"
  ]
  
attribute "lb_haproxy/ssl_redirect_pools",
  :display_name => "Redirect pools to ssl",
  :description =>
    "Comma separated list of pools for which a redirect rule will be" +
    " added to force http to https",
  :required => "optional",
  :default => "default",
  :recipes => [
    "lb_haproxy::setup_server"
  ]
