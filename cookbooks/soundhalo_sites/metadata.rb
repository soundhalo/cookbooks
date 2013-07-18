name             'soundhalo_sites'
maintainer       'Twobulls'
maintainer_email 'steve@two-bulls.com'
license          'All rights reserved'
description      'Installs/Configures app_soundhalo_sites'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "rightscale"
depends "apache2"
depends "repo"

recipe "soundhalo_sites::default",
  "Initializes variables"

recipe "soundhalo_sites::install_nodeJS",
  "What is says on the tin"

recipe "soundhalo_sites::install_php",
  "Installs the required php libraries for the blog"

recipe "soundhalo_sites::setup_vhosts",
  "Loops [:app] collection and creates a vhost entry for each one"

recipe "soundhalo_sites::update_code_desktop",
  "checkout or pull down code for desktop app. runs build script and restarts apache"

recipe "soundhalo_sites::update_code_mobile",
  "checkout or pull down code for mobile app. runs build script and restarts apache"

recipe "soundhalo_sites::update_code_www",
  "checkout or pull down code for www site."

recipe "soundhalo_sites::update_code_partners",
  "checkout or pull down code for partners site."
  
attribute "soundhalo_sites/apache_port",
  :display_name => "Apache port to listen on",
  :description => "",
  :required => "optional",
  :default => "80",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
  ]
  
attribute "soundhalo_sites/prod_url",
  :display_name => "soundhalo production url",
  :description => "Used for proxying api requests",
  :required => "required",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
  ]  
  
  
attribute "soundhalo_sites/ssl_certificate",
  :display_name => "ssl certificate",
  :required => "required",
  :description => "the ssl certificate",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
  ]  

attribute "soundhalo_sites/ssl_chain",
  :display_name => "ssl chain",
  :required => "required",
  :description => "the ssl chain cert from trusted provider",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
  ]  

attribute "soundhalo_sites/ssl_key",
  :display_name => "ssl key",
  :required => "required",
  :description => "the ssl key",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
  ]  

attribute "soundhalo_sites/app/mobile/git_repo",
  :display_name => "soundhalo mobile site git repo",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::update_code_mobile",
    "soundhalo_sites::default",
  ]

attribute "soundhalo_sites/app/mobile/git_branch",
  :display_name => "soundhalo mobile site git repo branch",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::update_code_mobile",
    "soundhalo_sites::default",
  ]
  
attribute "soundhalo_sites/app/mobile/web_url",
  :display_name => "soundhalo mobile site url",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
    "soundhalo_sites::update_code_mobile",
    "soundhalo_sites::default",
  ] 
  
attribute "soundhalo_sites/app/mobile/use_auth",
  :display_name => "Use http auth",
  :description => "Whether to use httpauth on vhost",
  :required => "required",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
  ] 

attribute "soundhalo_sites/app/mobile/redirect_non_ios",
  :display_name => "Redirect non-iOS devices",
  :description => "Whether to redirect all non-ios devices to soundhalo.com",
  :required => "required",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
  ]

attribute "soundhalo_sites/app/mobile/build_target",
  :display_name => "Node build script target",
  :description => "Only applicable when use_node=true",
  :default => "production",
  :required => "optional",
  :recipes => [
    "soundhalo_sites::update_code_mobile",
  ]
  
attribute "soundhalo_sites/app/desktop/git_repo",
  :display_name => "soundhalo desktop site git repo",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::update_code_desktop",
    "soundhalo_sites::default",
  ]

attribute "soundhalo_sites/app/desktop/git_branch",
  :display_name => "soundhalo mobile site git repo branch",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::update_code_desktop",
    "soundhalo_sites::default",
  ]

attribute "soundhalo_sites/app/desktop/web_url",
  :display_name => "soundhalo desktop site url",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
    "soundhalo_sites::update_code_desktop",
    "soundhalo_sites::default",
  ]
  
attribute "soundhalo_sites/app/desktop/use_auth",
  :display_name => "Use http auth",
  :description => "Whether to use httpauth on vhost",
  :required => "required",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
  ]

attribute "soundhalo_sites/app/desktop/build_target",
  :display_name => "Node build script target",
  :description => "Only applicable when use_node=true",
  :default => "production",
  :required => "optional",
  :recipes => [
    "soundhalo_sites::update_code_desktop",
  ]

attribute "soundhalo_sites/app/account/web_url",
  :display_name => "soundhalo account site url",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
    "soundhalo_sites::default",
  ]

attribute "soundhalo_sites/app/www/git_repo",
  :display_name => "soundhalo www site git repo",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::update_code_www",
    "soundhalo_sites::default",
  ]

attribute "soundhalo_sites/app/www/git_branch",
  :display_name => "soundhalo www site git repo branch",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::update_code_www",
    "soundhalo_sites::default",
  ]

attribute "soundhalo_sites/app/www/web_url",
  :display_name => "soundhalo www site url",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
    "soundhalo_sites::update_code_www",
    "soundhalo_sites::default",
  ] 

attribute "soundhalo_sites/app/www/use_auth",
  :display_name => "Use http auth",
  :description => "Whether to use httpauth on vhost",
  :required => "required",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
  ] 

attribute "soundhalo_sites/app/partners/git_repo",
  :display_name => "soundhalo partners site git repo",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::update_code_partners",
    "soundhalo_sites::default",
  ]

attribute "soundhalo_sites/app/partners/git_branch",
  :display_name => "soundhalo partners site git repo branch",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::update_code_partners",
    "soundhalo_sites::default",
  ]

attribute "soundhalo_sites/app/partners/web_url",
  :display_name => "soundhalo partners site url",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
    "soundhalo_sites::update_code_partners",
    "soundhalo_sites::default",
  ] 

attribute "soundhalo_sites/app/partners/use_auth",
  :display_name => "Use http auth",
  :description => "Whether to use httpauth on vhost",
  :required => "required",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
  ]