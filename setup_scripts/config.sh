
base=/home/smartboatnetwork

code=${base}/raspberry_pi
bin=${base}/bin
tmp=${base}/tmp
config=${base}/config

setup=${code}/setup_scripts
sources=${setup}/sources

mkdir -p ${tmp}
mkdir -p ${config}
mkdir -p ${bin}

# change these to connect to a wifi access point

SSID=""
PASSWORD=""
