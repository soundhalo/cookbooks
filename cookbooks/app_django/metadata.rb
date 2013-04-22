maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "Installs the Django application server."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "13.3.0"

# supports "centos", "~> 5.8", "~> 6.2"
# supports "redhat", "~> 5.8"
# supports "ubuntu", "~> 10.04", "~> 12.04"

depends "app"
depends "web_apache"
depends "db_mysql"
depends "db_postgres"
depends "repo"
depends "rightscale"
depends "python"

recipe "app_django::setup_server_1_4",
  "Installs the Django application server."

recipe "app_django::run_django_commands",
  "Runs specific user defined commands. Commands will be executed" +
  " in the app directory."

recipe "app_django::install_PIL",
  "Installs the python imaging library properly with jpeg and png support"

recipe "app_django::install_traceview",
  "Installs the traceview package"

recipe "app_django::install_crons",
  "Installs all crons needed by the app"

recipe "app_django::update_code_and_run_commands",
  "Use this update recipe when the instance is running to checkout code" +
  " and run correct methods"

attribute "app_django/app/debug_mode",
  :display_name => "Django App Debug Mode",
  :description =>
    "Creates a Django application debug environment variable," +
    " e.g. should be true for dev and false for prod environment." +
    " Example: false",
  :choice => ["true", "false"],
  :required => "optional",
  :default => "false",
  :recipes => ["app_django::setup_server_1_4"]

attribute "app_django/apache/serve_local_files",
  :display_name => "Apache serve local Files",
  :description =>
    "This option tells Apache whether it should serve the (static) content" +
    " itself. Currently, it will omit dynamic content, such as *.php," +
    " *.action, *.jsp, and *.do. Example: true",
  :choice => ["true", "false"],
  :required => "optional",
  :default => "true",
  :recipes => ["app_django::setup_server_1_4"]

attribute "app_django/project/opt_pip_list",
  :display_name => "Custom Python Package list",
  :description =>
    "A space-separated list of optional python package(s), along with their" +
    " versions in the Format: py-pkg1==version py-pkg2==version" +
    " py-pkg3==version. Example: simplejson==1.7.1, Markdown==2.0.3",
  :required => "optional",
  :default => "",
  :recipes => ["app_django::setup_server_1_4"]

attribute "app_django/app/environment",
  :display_name => "The environment to use",
  :description =>
    "Defaults to 'production",
  :required => "optional",
  :default => "production",
  :recipes => ["app_django::setup_server_1_4"]
  
attribute "app_django/app/name",
  :display_name => "The name of the django app",
  :description =>
    "Used to configure local_[x].py files",
  :recipes => ["app_django::setup_server_1_4"]

attribute "app_django/celery/broker_type",
  :display_name => "The broker type:",
  :choice => ["amqp", "redis", "mongo", "django"],
  :default => "amqp",
  :description =>
    "The celery broker type",
  :recipes => ["app_django::setup_server_1_4"]
  
attribute "app_django/celery/broker_host",
  :display_name => "The broker host",
  :description =>
    "The celery broker host",
  :recipes => ["app_django::setup_server_1_4"]

attribute "app_django/celery/broker_port",
  :display_name => "The broker port",
  :description =>
    "The celery broker port",
  :default => "5672",
  :recipes => ["app_django::setup_server_1_4"]

attribute "app_django/celery/broker_vhost",
  :display_name => "The broker vhost",
  :description =>
    "The celery broker vhost",
  :recipes => ["app_django::setup_server_1_4"]

attribute "app_django/celery/broker_user",
  :display_name => "The broker user",
  :description =>
    "The celery broker user",
  :recipes => ["app_django::setup_server_1_4"]

attribute "app_django/celery/broker_password",
  :display_name => "The broker password",
  :description =>
    "The celery broker password",
  :recipes => ["app_django::setup_server_1_4"]
  
  
attribute "app_django/app/enable_traceview",
  :display_name => "Enable traceview debugging",
  :description =>
    "Traceview is used to debug requests and can be enabled for testing." +
    " Note: should not be used when in production",
  :choice => ["true", "false"],
  :required => "optional",
  :default => "false",
  :recipes => ["app_django::setup_server_1_4"]
  
  
attribute "app_django/is_master",
  :display_name => "Django App Master",
  :description =>
  "Tags this instance as the django app master, for which the following" +
  "actions will occur: " +
  "1) All crons will be run on this instance"+
  "2) All django database operations will run on this instance",
  :choice => ["true", "false"],
  :default => "false",
  :recipes => ["app_django::update_code","app_django::install_crons","app_django::run_django_commands"]
