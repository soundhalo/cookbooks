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

recipe "app_django::run_custom_django_commands",
  "Runs specific user defined commands. Commands will be executed" +
  " in the app directory."

recipe "app_django::install_PIL",
  "Installs the python imaging library properly with jpeg and png support"

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

attribute "app_django/project/custom_cmd",
  :display_name => "Custom Django command",
  :description =>
    "A comma-separated list of optional commands which will be executed in" +
    " the app directory." +
    " Example: manage.py syncdb, manage.py migrate, manage.py loaddata" +
    " ./fixtures/example_initial_data.json",
  :required => "optional",
  :default => "",
  :recipes => ["app_django::run_custom_django_commands"]

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
  
