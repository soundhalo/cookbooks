name             'pgbouncer'
maintainer       'Two Bulls'
maintainer_email 'steve@two-bulls.com'
license          'All rights reserved'
description      'Installs/Configures pgbouncer'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

# supports "ubuntu", "~> 10.04", "~> 12.04"

%w{ ubuntu debian }.each do |os|
  supports os
end

depends "rightscale"

recipe "pgbouncer::default", 
  "Installs and configures pgbouncer"

# Where to wait for clients
attribute "pgbouncer/listen_addr",
  :display_name => "PgBouncer listen address",
  :description => "IP address or * which means all ip-s.",
  :default => "127.0.0.1"
attribute "pgbouncer/listen_port",
  :display_name => "PgBouncer listen port",
  :description => "Accept connections on the specified port.",
  :default => "6432"

# Authentication settings
attribute "pgbouncer/auth_type",
  :display_name => "PgBouncer authentication type",
  :description => "Specify the authentication type to use.",
  :choice => [ "any", "trust", "plain", "crypt", "md5" ],
  :default => "trust"

# Pooler personality questions
attribute "pgbouncer/pool_mode",
  :display_name => "PgBouncer pool mode",
  :description => "When server connection is released back to pool.",
  :choice => [ "session", "transaction", "statement" ],
  :default => "session"

# Connection limits
attribute "pgbouncer/max_client_conn",
  :display_name => "PgBouncer max client connections",
  :description => "Total number of clients that can connect.",
  :default => "100"
attribute "pgbouncer/default_pool_size",
  :display_name => "PgBouncer default pool size",
  :description => "PgBouncer default pool size.",
  :default => "20"
