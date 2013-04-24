
# Administrative settings
default[:pgbouncer][:logfile] = "/var/log/postgresql/pgbouncer.log"
default[:pgbouncer][:pidfile] = "/var/run/postgresql/pgbouncer.pid"

# Where to wait for clients
default[:pgbouncer][:listen_addr] = "127.0.0.1"
default[:pgbouncer][:listen_port] = "6432"
default[:pgbouncer][:unix_socket_dir] = "/var/run/postgresql"

# Authentication settings
default[:pgbouncer][:auth_type] = "trust"
default[:pgbouncer][:auth_file] = "/etc/pgbouncer/userlist.txt"

# Pooler personality questions
default[:pgbouncer][:pool_mode] = "session"

# Connection limits
default[:pgbouncer][:max_client_conn] = "100"
default[:pgbouncer][:default_pool_size] = "20"

# Timeouts

# Low-level tuning options