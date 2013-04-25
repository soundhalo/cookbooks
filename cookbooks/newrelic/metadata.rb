name             'newrelic'
maintainer       'Twobulls '
maintainer_email 'steve@two-bulls.com'
license          'All rights reserved'
description      'Installs/Configures newrelic'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ debian ubuntu redhat centos fedora scientific amazon }.each do |os|
  supports os
end

depends "rightscale"

recipe "newrelic::default", "Adds the New Relic repository, installs & configures the New Relic server monitor package."
recipe "newrelic::install", "Adds the New Relic repository."
recipe "newrelic::server-monitor", "Installs & configures the New Relic server monitor package."

attribute "newrelic/server_monitoring/license",
  :display_name => "newrelic license key",
  :description =>
    "newrelic license key",
  :required => "required",
  :recipes => ["newrelic::default"]