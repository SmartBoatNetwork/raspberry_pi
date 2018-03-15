
source /home/smartboatnetwork/raspberry_pi/setup_scripts/config.sh

cd ${base}

# install samba file sharing
sudo apt-get update
sudo apt-get upgrade

# before installing samba file sharing change the samba password
# for the pi samba user in the install script
# bash scripts/install_samba.sh

# remove a whole load of stuff we ain't gonna need
bash ${setup}/strip_pi.sh

# install essential things
bash ${setup}/install_essential.sh

# use raspi_config to enable stuff e.g. ssh

# install kplex multiplexer
# this may not be needed when using node-red as the multiplexer
# bash scripts/install_kplex.sh

# install opencpn
bash ${setup}/install_opencpn.sh

# install free charts for OpenCPN

# install the tools for AIS RTL SDR usb dongle
bash ${setup}/install_ais.sh

# and/or install the tools for weather by satellite
bash ${setup}/install_weathersat.sh

# install zyGrib
bash ${setup}/install_zygrib.sh

# install world maps
# http://www.zygrib.org/#section_maps

# install signalk-server-node
bash ${setup}/install_signalk.sh

# install vnc
bash ${setup}/install_vnc.sh

# install the packages for building node based IOT applications
bash ${setup}/install_iot.sh
bash ${setup}/install_devices.sh
bash ${setup}/install_node-red.sh

# clean up after everything is installed
sudo apt-get -y autoremove

echo "reboot to startup everything that was installed"
