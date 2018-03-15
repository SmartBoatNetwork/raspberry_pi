source /home/smartboatnetwork/raspberry_pi/setup_scripts/config.sh

# setup signalk
cd ${base}

if [ -d "signalk-server-node" ]; then
  (cd signalk-server-node && git pull)
else
  git clone https://github.com/SignalK/signalk-server-node.git
fi

sudo apt-get install -y libnss-mdns avahi-utils libavahi-compat-libdnssd-dev

(cd signalk-server-node && npm install && npm install mnds && sudo bash ./rpi-setup.sh)

sudo systemctl start signalk.service
sudo systemctl start signalk.socket

cd ${tmp}
sudo apt-get install -y xsltproc
git clone git://github.com/canboat/canboat
cd canboat
make

sudo cpan install Config::General

# change the following options to suit your requirements
cat >${config}/n2kd.conf<<n2kd_monitor
ACTISENSE_PRIMARY=/dev/actisense-can
MONITOR=true
N2KD_OPTIONS=--src-filter !3
ANALYZER_OPTIONS=-clocksrc 36
n2kd_monitor

sudo ln -s ${config}/n2kd.conf /etc/default/n2kd

/usr/local/bin/n2kd_monitor
