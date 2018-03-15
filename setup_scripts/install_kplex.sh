source /home/smartboatnetwork/raspberry_pi/setup_scripts/config.sh

cd ${tmp}

# install kplex
sudo apt remove -y kplex
if [ ! -f "kplex_1.3.4-1_armhf.deb" ]; then
  echo 'getting kplex in ' `pwd`
  wget http://www.stripydog.com/download/kplex_1.3.4-1_armhf.deb
fi
echo 'installing kplex'
sudo apt install -y ${tmp}/kplex_1.3.4-1_armhf.deb

sudo rm /etc/kplex.conf
cp ${sources}/kplex.conf ${config}/kplex.conf
sudo ln -s ${config}/kplex.conf /etc/kplex.conf
