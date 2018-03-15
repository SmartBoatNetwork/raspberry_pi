source /home/smartboatnetwork/raspberry_pi/setup_scripts/config.sh

# configure the pi wifi access point

sudo apt-get install dnsmasq hostapd

sudo systemctl stop dnsmasq
sudo systemctl stop hostapd


# configure the network IP
cat >${config}/wlan0.conf<<heredoc
allow-hotplug wlan0
iface wlan0 inet static
    address 192.168.1.1
    netmask 255.255.255.0
    network 192.168.1.0
heredoc

sudo ln -s ${config}/wlan0.conf /etc/network/interfaces.d/wlan0.conf

sudo service dhcpcd restart
sudo ifdown wlan0
sudo ifup wlan0

cat >${config}/dnsmasq.conf<<heredoc
interface=wlan0    # wireless interface is usually wlan0
  dhcp-range=192.168.1.2,192.168.1.20,255.255.255.0,24h
heredoc

sudo ln -s ${config}/dnsmasq.conf /etc/dnsmasq.conf

# create the hostapd config file
SSID=SmartBoat PASSWORD=SmartBoatNetwork bash ${setup}/create_ap.sh

sudo rm /etc/default/hostapd
cp ${sources}/hostapd.default ${config}/hostapd.default
sudo ln -s ${config}/hostapd.default /etc/default/hostapd

sudo service hostapd start
sudo service dnsmasq start
