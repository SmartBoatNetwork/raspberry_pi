source /home/smartboatnetwork/raspberry_pi/setup_scripts/config.sh

# remove old versions of nodejs and npm and install newer versions
# install some stuff we do need
sudo apt-get install -y git build-essential p7zip

# install later versions of node and npm
sudo apt-get remove -y npm nodejs
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
