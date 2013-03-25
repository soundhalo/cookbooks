tarball = "postgis-1.5.3.tar.gz"

set_unless[:postgis][:tarball_url] = "http://postgis.refractions.net/download/#{tarball}"
set_unless[:postgis][:tarball] = tarball
set_unless[:postgis][:template_name] = "gis"