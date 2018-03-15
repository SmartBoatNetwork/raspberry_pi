source /home/smartboatnetwork/raspberry_pi/setup_scripts/config.sh

mkdir -p ${base}/boot

cd ${tmp}

if [ ! -f "./opencpn_deps_installed" ]; then
  sudo apt-get update
  sudo apt-get upgrade
     # When it prompts you, type "Y" for Yes and hit enter. This may take a while
  sudo apt-get install -y cmake gettext git-core gpsd gpsd-clients \
  libgps-dev wx-common libwxgtk3.0-dev libglu1-mesa-dev libgtk2.0-dev \
  wx3.0-headers libbz2-dev libtinyxml-dev libportaudio2 portaudio19-dev \
  libcurl4-openssl-dev libexpat1-dev libcairo2-dev
  touch ./opencpn_deps_installed
fi

# When it prompts you, type "Y" for Yes and hit enter.
# This *will* take a long time, about 5 minutes depending on your internet speed
if [ ! -d "OpenCPN" ]; then
  git clone http://github.com/seandepagnier/OpenCPN -b rpi_fixes
fi

cd OpenCPN
git pull

if [ ! -d "build" ]; then
  sudo mkdir build
fi

cd build
sudo cmake ..
sudo make -j3

sudo make install

# modify the boot config for slow hardware
cp /boot/config.txt ${base}/boot/config.txt

cat >> ${base}/boot/config.txt <<bashScript

# Add these two lines so it can run on slow hardware:
framebuffer_depth=32
framebuffer_ignore_alpha=1

bashScript

# create a desktop shortcut
cp /usr/local/share/applications/opencpn.desktop /home/pi/Desktop/

# add tcp connection with no filtering
# /home/pi/.opencpn/opencpn.conf
# DataConnections=1;0;localhost;10110;0;;4800;1;0;1;;1;;1;0;0;0;1

echo opencpn installed now do sudo reboot
