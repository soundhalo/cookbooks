name             'pgpool2'
maintainer       'Twobulls'
maintainer_email 'steve@two-bulls.com'
license          'All rights reserved'
description      'Installs/Configures pgpool2'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

depends "rightscale"

recipe "pgpool2::default",
  "Installs and configures pgpool2 on machine"
  
recipe "pgpool2::attach_all",
  "Attaches all slave db's to pgpool"
  
recipe "pgpool2::attach_slave",
  "Called remotely from slave db. DO NOT USE"
  
recipe "pgpool2::detach_slave",
  "Called remotely from slave db. DO NOT USE"

attribute "pgpool2/num_init_children",
  :display_name => "number of children",
  :description =>
    "The nummber of connections in a pool",
  :required => "optional",
  :default => "20",
  :recipes => [
    "pgpool2::default",
  ]

attribute "pgpool2/max_pool",
  :display_name => "maximum pool size",
  :description =>
    "The total number of pools",
  :required => "optional",
  :default => "1",
  :recipes => [
    "pgpool2::default",
  ]

attribute "pgpool2/listen_url",
  :display_name => "pgpool2 listen url",
  :description =>
    "pgpools listen url",
  :default => "127.0.0.1",
  :recipes => [
    "pgpool2::default",
  ]
    
attribute "pgpool2/listen_port",
  :display_name => "pgpools listen port",
  :description =>
    "pgpools listen port",
  :default => "5433",
  :recipes => [
    "pgpool2::default",
  ]

attribute "pgpool2/read_backend/weight",
  :display_name => "read slave weighting",
  :description =>
    "The weighting to use for each read slave",
  :default => "2",
  :recipes => [
    "pgpool2::default",
    "pgpool2::attach_slave",
    "pgpool2::attach_all",
    "pgpool2::detach_slave"
  ]

attribute "pgpool2/write_backend/url",
  :display_name => "the url of the write backend",
  :description =>
    "This should be left as default",
  :default => "db-master.soundhalo.com",
  :recipes => [
    "pgpool2::default",
  ]

attribute "pgpool2/write_backend/port",
  :display_name => "the port of the write backend",
  :description =>
    "This should be left as default",
  :default => "5432",
  :recipes => [
    "pgpool2::default",
  ]

attribute "pgpool2/write_backend/weight",
  :display_name => "the weight of the write backend",
  :description =>
    "This should be left as default",
  :default => "1",
  :recipes => [
    "pgpool2::default",
  ]

