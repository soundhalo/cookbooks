maintainer       "Twobulls Pty Ltd"
maintainer_email "steve@two-bulls.com"
license          ""
description      "Installs/configures a PostgreSQL database client and server with automated backups, and encoding"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "13.3.0"

# supports "centos", "~> 5.8", "~> 6"
# supports "redhat", "~> 5.8"
# supports "ubuntu", "~> 10.04", "~> 12.04"

depends "sys_dns"
depends "db"
depends "rightscale"
depends "block_device"

recipe "db_postgres::setup_server_9_1",
  "Sets the DB PostgreSQL provider. Sets version 9.1 and node variables" +
  " specific to PostgreSQL 9.1."

recipe "db_postgres::do_set_slave_sync_mode",
  "Sets master to do sync-based replication with slaves." +
  " PostgreSQL streaming replication is asynchronous by default." +
  " If the primary server crashes then some transactions" +
  " that were committed may not have been replicated to the standby server," +
  " causing data loss. The amount of data loss is proportional" +
  " to the replication delay at the time of failover. Synchronous replication" +
  " offers the ability to confirm that all changes made by a transaction" +
  " have been transferred to one synchronous standby server." +
  " This extends the standard level of durability offered by a transaction" +
  " commit. This level of protection is referred to as 2-safe replication" +
  " in computer science theory. For more info refer:" +
  " http://www.postgresql.org/docs/9.1/static/warm-standby.html#SYNCHRONOUS-REPLICATION "

recipe "db_postgres::do_set_slave_async_mode",
  "Sets master to do async-based replication with slaves. For more info" +
  "refer: http://www.postgresql.org/docs/9.1/static/warm-standby.html#SYNCHRONOUS-REPLICATION"

recipe "db_postgres::do_show_slave_sync_mode",
  "Shows the sync mode used for replication."

recipe "db_postgres::do_slave_attach_pgpool",
  "Attaches the slave to all app servers running pgpool."
    
recipe "db_postgres::do_slave_detach_pgpool",
  "Detaches the slave from all app servers running pgpool."
  
attribute "db_postgres",
  :display_name => "General Database Options",
  :type => "hash"

# == Default attributes
#
attribute "db_postgres/server_usage",
  :display_name => "Server Usage",
  :description =>
    "Use 'dedicated' if the PostgreSQL config file allocates all existing" +
    " resources of the machine. Use 'shared' if the PostgreSQL config file" +
    " is configured to use less resources so that it can be run concurrently" +
    " with other apps like Apache and Rails for example." +
    " Example: dedicated",
  :recipes => ["db_postgres::setup_server_9_1"],
  :choice => ["shared", "dedicated"],
  :default => "dedicated"

attribute "db_postgres/database_name",
  :display_name => "Database Name",
  :description =>
    "Enter the name of the PostgreSQL database for setting up monitoring." +
    " Example: mydbname",
  :required => true,
  :recipes => ["db_postgres::setup_server_9_1"]

attribute "db_postgres/encoding",
  :display_name => "Database Encoding",
  :description =>
    "Defaults to 'UTF8' but allows for overriding the default database templating encoding",
  :recipes => ["db_postgres::setup_server_9_1","db::install_server"],
  :default => "UTF8"

