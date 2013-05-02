#
# Cookbook Name:: Pgpool

module Twobulls
  module PGPool
    module Helper

      # @param [String] pool_name virtual hosts name.
      #
      # @return [Set] attached_servers set of attached servers which will be in the same pool i.e., servers in lb config dir
      #
      def get_attached_servers()
        attached_servers = Set.new
        servers_d = "/etc/pgpool2/servers.d/"
        Dir.entries(servers_d).select do |file|
          next if file == "." or file == ".."
          attached_servers.add?(file)
        end if (::File.directory?(servers_d))

        attached_servers
      end

      #
      # @return [Hash] slave_servers hash of app servers in deployment answering for pool_name
      #
      def query_databaseslaves()
        slave_servers = Hash.new

        # See cookbooks/rightscale/providers/server_collection.rb for the "load" action
        r=rightscale_server_collection 'db_slaves' do
          tags 'rs_dbrepl:slave_instance_uuid'
          mandatory_tags ['server:uuid=*', 'server:private_ip_0=*','database:active=true']
          action :nothing
        end
        r.run_action(:load)

        node[:server_collection]['db_slaves'].to_hash.values.each do |tags|
          # See cookbooks/rightscale/libraries/helper.rb for the "get_tag_value" method.
          uuid = RightScale::Utils::Helper.get_tag_value('server:uuid', tags)
          ip = RightScale::Utils::Helper.get_tag_value('server:private_ip_0', tags)
          slave_servers[uuid] = {}
          slave_servers[uuid][:ip] = ip
        end

        slave_servers
      end

    end
  end
end
