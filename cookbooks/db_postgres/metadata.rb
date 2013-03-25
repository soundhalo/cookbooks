maintainer       "Steve Cassidy - Twobulls"
maintainer_email "steve@two-bulls.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "Installs/configures a PostgreSQL database client and server with automated backups."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

attribute "db_postgres/encoding",
  :display_name => "Database Encoding",
  :description =>
    "Defaults to 'UTF8' but allows for overriding the default database templating encoding",
  :recipes => ["db_postgres::setup_server_9_1","db::install_server"],
  :default => "UTF8"