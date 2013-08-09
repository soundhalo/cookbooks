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

default[:app_django][:app][:environment] = "production"
default[:app_django][:app][:name] = ""
default[:app_django][:app][:cloudfront_id] = "E20S8BVW8BAZCW"
default[:app_django][:app][:email_subject] = "[Soundhalo PRODUCTION Server]"
default[:app_django][:app][:default_from_email] = "soundhalo <root@soundhalo.com>"
default[:app_django][:app][:registration_site_id] = "1"
default[:app_django][:app][:registration_desktop_redirect_url] = "https://app.soundhalo.com"
default[:app_django][:app][:registration_mobile_redirect_url] = "https://m.soundhalo.com"
default[:app_django][:app][:registration_android_redirect_url] = "soundhalo://"

default[:app_django][:celery][:broker_type] = "amqp"
default[:app_django][:celery][:broker_host] = ""
default[:app_django][:celery][:broker_port] = "5672"
default[:app_django][:celery][:broker_vhost] = ""
default[:app_django][:celery][:broker_user] = ""
default[:app_django][:celery][:broker_password] = ""
default[:app_django][:app][:enable_newrelic] = "True"

set[:app_django][:app][:enable_traceview] = "False"
set[:app_django][:trace_view_key] = "01ffc16d-a622-4dbb-9840-a6fb6844c70b"

# the master app server will run db sync and migration
# operations as well as have cron jobs
default[:app_django][:is_master] = "false"

# the crons to be run
set[:app_django][:crons] = [{"command" => "update_facebook_counts", "hour" => "23", "minute" => "00"},
                            {"command" => "cleanup_objects", "hour" => "23", "minute" => "00"},
                            {"command" => "extend_facebook_tokens", "hour" => "23", "minute" => "00"},
                            {"command" => "settle_payments", "hour" => "*", "minute" => "00"}]
                            
# django cache setting
default[:app_django][:app][:cache][:timeout] = 1 # seconds
default[:app_django][:app][:cache][:url] = "127.0.0.1"
default[:app_django][:app][:cache][:port] = "11211"
default[:app_django][:app][:cache][:max_entries] = 1000

default[:app_django][:db][:autocommit] = 'True'

