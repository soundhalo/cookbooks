name             'soundhalo_sites'
maintainer       'Twobulls'
maintainer_email 'steve@two-bulls.com'
license          'All rights reserved'
description      'Installs/Configures app_soundhalo_sites'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "rightscale"
depends "apache2"

recipe "soundhalo_sites::default",
  "Initializes variables"

recipe "soundhalo_sites::install_nodeJS",
  "What is says on the tin"

recipe "soundhalo_sites::setup_vhosts",
  "Loops [:app] collection and creates a vhost entry for each one"

recipe "soundhalo_sites::update_code_desktop",
  "checkout or pull down code for desktop app. runs build script and restarts apache"

recipe "soundhalo_sites::update_code_mobile",
  "checkout or pull down code for mobile app. runs build script and restarts apache"

recipe "soundhalo_sites::update_code_all",
  "checkout or pull down code for all apps. runs build script and restarts apache"

attribute "soundhalo_sites/apache_port",
  :display_name => "Apache port to listen on",
  :description => "",
  :required => "optional",
  :default => "80",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
  ]

attribute "soundhalo_sites/use_auth",
  :display_name => "Use http auth",
  :description => "Whether to use httpauth on vhost",
  :required => "optional",
  :default => "true",
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
  
attribute "soundhalo_sites/app/mobile/git_repo",
  :display_name => "soundhalo mobile site git repo",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::update_code_mobileweb",
    "soundhalo_sites::update_code_all",
    "soundhalo_sites::default",
  ]
  
attribute "soundhalo_sites/app/mobile/web_url",
  :display_name => "soundhalo mobile site url",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
    "soundhalo_sites::update_code_mobileweb",
    "soundhalo_sites::update_code_all",
    "soundhalo_sites::default",
  ]  
  
attribute "soundhalo_sites/app/desktop/git_repo",
  :display_name => "soundhalo desktop site git repo",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::update_code_desktop",
    "soundhalo_sites::update_code_all",
    "soundhalo_sites::default",
  ]

attribute "soundhalo_sites/app/desktop/web_url",
  :display_name => "soundhalo desktop site url",
  :description => "",
  :required => "required",
  :recipes => [
    "soundhalo_sites::setup_vhosts",
    "soundhalo_sites::update_code_desktop",
    "soundhalo_sites::update_code_all",
    "soundhalo_sites::default",
  ]