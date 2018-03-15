source /home/smartboatnetwork/raspberry_pi/setup_scripts/config.sh

# copy the udev usb rules

sudo cp ${sources}/99-usb-serial.rules /etc/udev/rules.d/
