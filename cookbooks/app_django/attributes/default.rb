#
# Cookbook Name:: app_django
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

# List of required apache modules
set[:app][:module_dependencies] = ["proxy", "proxy_http"]

# By default apache will serve any existing local files directly (except actionable ones)
default[:app_django][:apache][:serve_local_files] = "true"
# Setting Django version
set[:app_django][:version] = "1.4"
# Django application debug mode - https://docs.djangoproject.com/en/dev/ref/settings/#debug
default[:app_django][:app][:debug_mode] = "False"
# Path to PIP executable
set[:app_django][:pip_bin] = "/usr/bin/pip"
# Path to python executable
set[:app_django][:python_bin] = "/usr/bin/python"
# List of additional python packages, required for django application
default[:app_django][:project][:opt_pip_list] = ""
# List of python commands required for django application initialization
default[:app_django][:project][:custom_cmd] = ""

default[:app_django][:app][:environment] = "production"
default[:app_django][:app][:name] = ""
default[:app_django][:app][:enable_traceview] = "False"

default[:app_django][:celery][:broker_type] = "amqp"
default[:app_django][:celery][:broker_host] = ""
default[:app_django][:celery][:broker_port] = "5672"
default[:app_django][:celery][:broker_vhost] = ""
default[:app_django][:celery][:broker_user] = ""
default[:app_django][:celery][:broker_password] = ""

set[:app_django][:trace_view_key] = "01ffc16d-a622-4dbb-9840-a6fb6844c70b"
set[:app_django][:app][:enable_newrelic] = "True"

# the master app server will run db sync and migration
# operations as well as have cron jobs
default[:app_django][:is_master] = "false"

# the crons to be run
set[:app_django][:crons] = [{"command" => "update_facebook_counts", "hour" => "23", "minute" => "00"},
                            {"command" => "cleanup_objects", "hour" => "23", "minute" => "00"},
                            {"command" => "extend_facebook_tokens", "hour" => "23", "minute" => "00"},
                            {"command" => "settle_payments", "hour" => "*", "minute" => "00"}]
