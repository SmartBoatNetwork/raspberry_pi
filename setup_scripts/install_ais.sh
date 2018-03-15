source /home/smartboatnetwork/raspberry_pi/setup_scripts/config.sh

sudo apt-get install -y libusb-1.0-0-dev

cd ${tmp}

if [ ! -d "rtl-sdr" ]; then
  git clone git://git.osmocom.org/rtl-sdr.git
fi
cd rtl-sdr/
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON
make
sudo make install
sudo ldconfig
sudo cp ../rtl-sdr.rules /etc/udev/rules.d/

cd ${tmp}
# now build the ais program
git clone https://github.com/dgiardini/rtl-ais
cd rtl-ais
make
sudo cp rtl-ais /usr/local/bin

sudo cp ${sources}/blacklist-rtl.conf /etc/modprobe.d/

echo "reboot required for ais dongle"
