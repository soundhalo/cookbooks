rightscale_marker :begin

subfolder = "/contrib/postgis-1.5"
template = node[:postgis][:template_name]
execute 'create_postgis_template' do
  not_if "su postgres -c 'psql -qAt --list' | grep -q '^#{node[:postgis][:template_name]}\|'"
  command <<CMD
(su postgres -c "createdb -E UTF8 #{template} -T template0") &&
(su postgres -c "psql -d #{template} -f `pg_config --sharedir`#{subfolder}/postgis.sql") &&
(su postgres -c "psql -d #{template} -f `pg_config --sharedir`#{subfolder}/spatial_ref_sys.sql")
CMD
  action :run
end

rightscale_marker :end