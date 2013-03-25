maintainer       "Two Bulls"
maintainer_email "steve@two-bulls.com"
license          "NA"
description      "Installs and configures Postgis 1.5 onto Postgresql 9.1"
version          "1.0.0"

# supports "centos", "~> 5.8", "~> 6"

recipe "postgis::default",
  "Does nothing"
  
recipe "postgis::install_and_configure",
  "Installs and configures the PostGIS"
  
recipe "postgis::add_geo_template",
  "Adds a geo template with appropiate data into the database"