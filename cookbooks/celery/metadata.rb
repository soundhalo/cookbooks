maintainer       "Steve Cassidy"
maintainer_email "steve@two-bulls.com"
license          "N/A"
description      "Installs/Configures celery"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "1.0.0"

supports "ubuntu" # It should work on debian too, but not tested yet

depends "python"
depends "app"
depends "app_django"

recipe           "celery::default",
  "Include Celery daemon install/configuration"
recipe           "celery::user",
  "Create an user to run Celery daemon"
recipe           "celery::do_restart",
  "Restarts the celery daemon"
recipe           "celery::do_start",
  "Starts the celery daemon"
recipe           "celery::do_stop",
  "Stops the celery daemon"
recipe           "celery::setup_logrotate",
  "Adds logrotation to celery log files"

attribute "celery/log_dir",
  :display_name => "Log directory",
  :description  => "Celery daemon log directory",
  :default      => "/var/log/celery"

attribute "celery/log_level",
  :display_name => "Log level",
  :description  => "Celery daemon log level",
  :default      => "info"

attribute "celery/concurrency",
  :display_name => "Celery processes running",
  :description  => "The number of celery processes to run",
  :default      => "8"

attribute "celery/events",
  :display_name => "Events enabled",
  :description  => "Enables celery events notifications",
  :default      => "true"

attribute "celery/user",
  :display_name => "Celery user",
  :description  => "Celery daemon user",
  :default      => "celery"

attribute "celery/group",
  :display_name => "Celery group",
  :description  => "Celery daemon group",
  :default      => "celery"

