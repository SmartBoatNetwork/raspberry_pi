source /home/smartboatnetwork/raspberry_pi/setup_scripts/config.sh

if [ "${SSID}" == "" ] ; then
  echo SSID environment variable required
  exit
fi

if [ "${PASSWORD}" == "" ] ; then
  echo PASSWORD environment variable required
  exit
fi

sudo cp /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf.bak
wpa_passphrase ${SSID} ${PASSWORD} | sudo cat - > /etc/wpa_supplicant/wpa_supplicant.conf
