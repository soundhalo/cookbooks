maintainer       "Steve Cassidy"
maintainer_email "steve@two-bulls.com"
license          "N/A"
description      "Installs/Configures celery"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
recipe           "celery", "Include Celery daemon install/configuration"
recipe           "celery::user", "Create an user to run Celery daemon"

supports "ubuntu" # It should work on debian too, but not tested yet

depends "python"
depends "app"
depends "app_django"

attribute "celery/log_dir",
  :display_name => "Log directory",
  :description  => "Celery daemon log directory",
  :default      => "/var/log/celery"

attribute "celery/log_level",
  :display_name => "Log level",
  :description  => "Celery daemon log level",
  :default      => "info"

attribute "celery/workers",
  :display_name => "Celery workers",
  :description  => "Celery workers to be spawned",
  :default      => "1"

attribute "celery/events",
  :display_name => "Events enabled",
  :description  => "Enables celery events notifications",
  :default      => "true"

attribute "celery/create_user",
  :display_name => "Create user",
  :description  => "Enables celery user creation",
  :default      => "false"

attribute "celery/user",
  :display_name => "Celery user",
  :description  => "Celery daemon user",
  :default      => "celery"

attribute "celery/group",
  :display_name => "Celery group",
  :description  => "Celery daemon group",
  :default      => "celery"

