source /home/smartboatnetwork/raspberry_pi/setup_scripts/config.sh

if [ "${SSID}" == "" ] ; then
  echo SSID environment variable required
  exit
fi

if [ "${PASSWORD}" == "" ] ; then
  echo PASSWORD environment variable required
  exit
fi

cat >${config}/hostapd.conf<<heredoc
interface=wlan0
driver=nl80211
ssid=${SSID}
hw_mode=g
channel=7
wmm_enabled=0
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=${PASSWORD}
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
heredoc
