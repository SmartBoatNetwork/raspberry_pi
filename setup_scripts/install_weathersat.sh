source /home/smartboatnetwork/raspberry_pi/setup_scripts/config.sh

sudo apt-get install -y sox at predict

cd ${tmp}

wget http://www.wxtoimg.com/beta/wxtoimg-armhf-2.11.2-beta.deb
sudo dpkg -i wxtoimg-armhf-2.11.2-beta.deb
echo YES | wxtoimg

# in order for wxtoimg to work it needs to know where we are
# so start with any location - we can update the location with node-red
cat >> ~/.wxtoimgrc <<wxtoimgrcconf
Latitude: 13.8320
Longitude: 100.5600
Altitude: 0
wxtoimgrcconf

cd ${base}
mkdir -p ~/weather/predict
cp ${sources}/weathersat_*.sh !$
chmod +x !$/*.sh

# build a qfa antenna
# http://metsat.gogan.org/ant_qha.htm
# https://www.youtube.com/watch?v=CrFoA-aJZng
# http://jcoppens.com/ant/qfh/calc.en.php
# http://www.g4ilo.com/qfh.html
# https://www.youtube.com/watch?v=KU75FSA6o2M
# www.aribra.it/autocostruzione/qfh/qfh.pdf
# http://www.gregorystrike.com/2010/05/16/quadrifilar-helix-antenna-137-mhz/
