name             'soundhalo_clients'
maintainer       'Twobulls'
maintainer_email 'steve@two-bulls.com'
license          'All rights reserved'
description      'Installs/Configures app_soundhalo_clients'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.1'

depends "rightscale"
depends "apache2"
depends "repo"
depends "app"

recipe "soundhalo_clients::default",
  "Initializes variables"

recipe "soundhalo_clients::install_nodeJS",
  "What is says on the tin"

recipe "soundhalo_clients::install_php",
  "Installs the required php libraries for the blog"

recipe "soundhalo_clients::setup_vhosts",
  "Loops [:app] collection and creates a vhost entry for each one"

recipe "soundhalo_clients::update_code_desktop",
  "checkout or pull down code for desktop app. runs build script and restarts apache"

recipe "soundhalo_clients::update_code_mobile",
  "checkout or pull down code for mobile app. runs build script and restarts apache"

recipe "soundhalo_clients::do_loadbalancers_allow",
  "Allows connections from all load balancers within a given listener pool" +
  " which are tagged with loadbalancer:lb=<applistener_name>." +
  " This script should be run on an application server before it makes" +
  " a request to be connected to the load balancers."

recipe "soundhalo_clients::do_loadbalancers_deny",
  "Denies connections from all load balancers which are tagged with" +
  " loadbalancer:lb=<applistener_name>. For example, you can run this" +
  " script on an application server to deny connections from all load" +
  " balancers within a given listener pool."

recipe "soundhalo_clients::request_loadbalancer_allow",
  "Sends a request to all application servers tagged with" +
  " loadbalancer:app=<applistener_name> to allow connections from the server's" +
  " private IP address. This script should be run on a load balancer before" +
  " any application servers are attached to it."

recipe "soundhalo_clients::request_loadbalancer_deny",
  "Sends a request to all application servers tagged with" +
  " loadbalancer:app=<applistener_name> to deny connections from the server's" +
  " private IP address. This script should be run on a load balancer after" +
  " disconnecting application servers or upon decommissioning."
    
recipe "soundhalo_clients::handle_loadbalancers_allow",
  "Runs remote recipe on app server from loadbalancer requesting access." +
  " DO NOT RUN."

recipe "soundhalo_clients::handle_loadbalancers_deny",
  "Runs remote recipe on app server from loadbalancer revoking access." +
  " DO NOT RUN."    
  
attribute "soundhalo_clients/apache_port",
  :display_name => "Apache port to listen on",
  :description => "",
  :required => "optional",
  :default => "80",
  :recipes => [
    "soundhalo_clients::setup_vhosts",
  ]
  
attribute "soundhalo_clients/prod_url",
  :display_name => "soundhalo production url",
  :description => "Used for proxying api requests",
  :required => "required",
  :recipes => [
    "soundhalo_clients::setup_vhosts",
  ]  
  
attribute "soundhalo_clients/app/mobile/git_repo",
  :display_name => "soundhalo mobile site git repo",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_clients::update_code_mobile",
    "soundhalo_clients::default",
  ]

attribute "soundhalo_clients/app/mobile/git_branch",
  :display_name => "soundhalo mobile site git repo branch",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_clients::update_code_mobile",
    "soundhalo_clients::default",
  ]
  
attribute "soundhalo_clients/app/mobile/web_url",
  :display_name => "soundhalo mobile site url",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_clients::setup_vhosts",
    "soundhalo_clients::update_code_mobile",
    "soundhalo_clients::default",
  ] 
  
attribute "soundhalo_clients/app/mobile/use_auth",
  :display_name => "Use http auth",
  :description => "Whether to use httpauth on vhost",
  :required => "required",
  :recipes => [
    "soundhalo_clients::setup_vhosts",
  ] 

attribute "soundhalo_clients/app/mobile/build_target",
  :display_name => "Node build script target",
  :description => "Only applicable when use_node=true",
  :default => "production",
  :required => "optional",
  :recipes => [
    "soundhalo_clients::update_code_mobile",
  ]
  
attribute "soundhalo_clients/app/desktop/git_repo",
  :display_name => "soundhalo desktop site git repo",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_clients::update_code_desktop",
    "soundhalo_clients::default",
  ]

attribute "soundhalo_clients/app/desktop/git_branch",
  :display_name => "soundhalo mobile site git repo branch",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_clients::update_code_desktop",
    "soundhalo_clients::default",
  ]

attribute "soundhalo_clients/app/desktop/web_url",
  :display_name => "soundhalo desktop site url",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_clients::setup_vhosts",
    "soundhalo_clients::update_code_desktop",
    "soundhalo_clients::default",
  ]
  
attribute "soundhalo_clients/app/desktop/use_auth",
  :display_name => "Use http auth",
  :description => "Whether to use httpauth on vhost",
  :required => "required",
  :recipes => [
    "soundhalo_clients::setup_vhosts",
  ]

attribute "soundhalo_clients/app/desktop/build_target",
  :display_name => "Node build script target",
  :description => "Only applicable when use_node=true",
  :default => "production",
  :required => "optional",
  :recipes => [
    "soundhalo_clients::update_code_desktop",
  ]