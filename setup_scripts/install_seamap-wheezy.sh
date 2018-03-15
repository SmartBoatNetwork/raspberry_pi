source /home/smartboatnetwork/raspberry_pi/setup_scripts/config.sh

# install openseamap tile server

# https://switch2osm.org/serving-tiles/manually-building-a-tile-server-14-04/

cd ${tmp}

username=smartboatnetwork_pg

# install dependencies
sudo apt-get install libboost-all-dev subversion git-core tar unzip wget bzip2 build-essential autoconf libtool libxml2-dev libgeos-dev libgeos++-dev libpq-dev libbz2-dev libproj-dev munin-node munin libprotobuf-c0-dev protobuf-c-compiler libfreetype6-dev libpng12-dev libtiff4-dev libicu-dev libgdal-dev libcairo-dev libcairomm-1.0-dev apache2 apache2-dev libagg-dev liblua5.2-dev ttf-unifont lua5.1 liblua5.1-dev libgeotiff-epsg node-carto

# install postgres
sudo apt-get install postgresql postgresql-contrib postgis postgresql-9.3-postgis-2.1

# answer yes for superuser (although this isn't strictly necessary)
sudo -u postgres -i
createuser $username
createdb -E UTF8 -O $username gis
exit

# Create a Unix user for this user, too, choosing a password when prompted:
sudo useradd -m $username
sudo passwd $username

sudo -u postgres psql
\c gis
CREATE EXTENSION postgis;
ALTER TABLE geometry_columns OWNER TO $username;
ALTER TABLE spatial_ref_sys OWNER TO $username;
\q
exit

# install osm2pgsql from source
cd ${tmp}
git clone git://github.com/openstreetmap/osm2pgsql.git
cd osm2pgsql
./autogen.sh
./configure
make
sudo make install

# install mapnick
cd ${tmp}
git clone git://github.com/mapnik/mapnik
cd mapnik
git branch 2.2 origin/2.2.x
git checkout 2.2

python scons/scons.py configure INPUT_PLUGINS=all OPTIMIZATION=3 SYSTEM_FONTS=/usr/share/fonts/truetype/
make
sudo make install
sudo ldconfig

# verify mapnick install

echo "import mapnik" | python
#>>> import mapnik

# install mod_tile and renderd

cd ${tmp}

git clone git://github.com/openstreetmap/mod_tile.git
cd mod_tile
./autogen.sh
./configure
make
sudo make install
sudo make install-mod_tile
sudo ldconfig

# Download OSM Bright stylesheet

sudo mkdir -p /usr/local/share/maps/style
sudo chown username /usr/local/share/maps/style
cd /usr/local/share/maps/style
wget https://github.com/mapbox/osm-bright/archive/master.zip
wget http://data.openstreetmapdata.com/simplified-land-polygons-complete-3857.zip
wget http://data.openstreetmapdata.com/land-polygons-split-3857.zip
mkdir ne_10m_populated_places_simple
cd ne_10m_populated_places_simple
wget http://www.naturalearthdata.com/download/10m/cultural/ne_10m_populated_places_simple.zip
# wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_populated_places_simple.zip
unzip ne_10m_populated_places_simple.zip
rm ne_10m_populated_places_simple.zip
cd ..

unzip '*.zip'
mkdir osm-bright-master/shp
mv land-polygons-split-3857 osm-bright-master/shp/
mv simplified-land-polygons-complete-3857 osm-bright-master/shp/
mv ne_10m_populated_places_simple osm-bright-master/shp/

cd osm-bright-master/shp/land-polygons-split-3857
shapeindex land_polygons.shp
cd ../simplified-land-polygons-complete-3857/
shapeindex simplified_land_polygons.shp
cd ../..

# Configuring OSM Bright see doc
nano osm-bright/osm-bright.osm2pgsql.mml
