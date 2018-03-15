source /home/smartboatnetwork/raspberry_pi/setup_scripts/config.sh


mkdir -p ${base}/boot
cd ${tmp}

wget http://www.zygrib.org/getfile.php?file=zyGrib-8.0.1.tgz
tar xzf zyGrib-8.0.1.tgz

sudo apt-get install -y build-essential g++ make libbz2-dev zlib1g-dev libproj-dev
sudo apt-get install -y libnova-dev nettle-dev libpng-dev libjpeg-dev libjasper-dev
sudo apt-get install -y qtbase5-dev qt5-default

cd zyGrib-8.0.1
make
make install

sudo apt-get -y autoremove

bash ${sources}/gshhs_maps2_cities_deb_install
