#
# Cookbook Name:: pgpool2
#

default[:pgpool2][:num_init_children] = 20
default[:pgpool2][:max_pool] = 1
default[:pgpool2][:listen_port] = 5433
default[:pgpool2][:read_backend][:weight] = 2

default[:pgpool2][:write_backend][:url] = 'db-master.soundhalo.com'
default[:pgpool2][:write_backend][:port] = '5432'
default[:pgpool2][:write_backend][:weight] = 1
