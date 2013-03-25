rightscale_marker :begin

subfolder = "/contrib/postgis-1.5"
template = node[:postgis][:template_name]
execute 'create_postgis_template' do
  not_if "su postgres -c 'psql -qAt --list' | grep -q '^#{node[:postgis][:template_name]}\|'"
  user 'postgres'
  command <<CMD
(createdb -E UTF8 #{template} -T template0) &&
(psql -d #{template} -c "UPDATE pg_database SET datistemplate='true' WHERE datname='#{template}';") &&
(psql -d #{template} -f `pg_config --sharedir`#{subfolder}/postgis.sql) &&
(psql -d #{template} -f `pg_config --sharedir`#{subfolder}/spatial_ref_sys.sql)
CMD
  action :run
end

rightscale_marker :end