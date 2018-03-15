# Setup Scripts

A collection of scripts to install and configure the raspberry Pi for marine
data applications.  If you don't know
what a raspberry Pi is then head on over to https://www.raspberrypi.org/ and
check it out.  This tiny computer runs a version of Linux (a Unix operating
system) called Raspbian (which is based on Debian).

This project aims to make it a bit easier to get a raspberry Pi up and running
with a suite of applications aimed at the marine environment.  The main
applications installed are OpenCPN and SignalK.

This project assumes a Raspberry Pi 3 although earlier versions may also work
to some degree however things will run a lot better with the 1GB RAM of the Pi 3.

Also we hope to collect information and designs for hardware projects to
interface with the Pi, everything you will need to turn a Raspberry Pi into a
super useful tool for your boat network all in one place.

### Smart Boat Network

This project is part of Smart Boat Network.  
Visit http://www.smartboatnetwork.com for more information.

### SmartBox

SmartBox is a program that runs on your Raspberry Pi and is the main control unit
in a Smart Boat Network.

### OpenCPN

OpenCPN is a popular open source chart plotting program that has been in development for
a number of years and is available on various platforms including the Pi.
You can find out more about OpenCPN by visiting the OpenCPN website at
https://opencpn.org

### SignalK

SignalK is the new open source universal marine data communication protocol and
will soon become the de-facto standard way for applications and devices on boats
to talk to each other.  You can find out more about SignalK by visiting the
SignalK website at http://signalk.org

### Node-RED
Node-RED is a programming tool for wiring together hardware devices, APIs and
online services in new and interesting ways. It provides a browser-based editor
that makes it easy to wire together flows using the wide range of nodes in the
palette that can be deployed to its runtime in a single-click.

Smart Boat Network uses Node-RED to wire together data flows from SignalK, SmartBox and NMEA
data stream providers.

### See Also

OpenPlotter is a raspberry Pi based system with a suite of applications already
installed including OpenCPN and SignalK.  Visit http://http://www.sailoog.com/en/openplotter
for more information.

## Installation

Download the raspberry Pi debian image from the raspberry Pi website at
https://www.raspberrypi.org/downloads/raspbian/

There are 2 images available.  The lite version does not have a desktop window
system and occupies a lot less disk space.  However if you want to install and
run OpenCPN you will need the version with the desktop.  Unzip the downloaded
zip file and follow the Installation
instructions for your operating system to burn the image to an SD card.

### mount the pi image on a folder (optional)

If you want to modify the Pi image before you boot the Pi and you are running
linux or some other flavour of Unix (and you know what you
are doing :-) you can mount the image onto your local file system with a command
like this;

```
mount -o loop,offset=$(( 512 * 94208 )) VERSION-raspbian-stretch.img /mountpoint
```

Where VERSION is a date in iso format that identifies the version of the downloaded
image and /mountpoint is a path on your file system.

### Configure wifi

The first thing you will need to do is configure internet access for the Pi.
If you have downloaded and booted into the desktop version and have connected
a HDMI screen, keyboard and mouse then it simply a case of clicking on the network
icon in the top panel and configure through the GUI interface.

If you need to configure wifi access manually then the following programs will
be useful - iwlist and wpa_supplicant, e.g.

```
iwlist wlan0 scan
```
will scan and list the access points visible to the Pi.

### configure wifi with wpa_supplicant

wpa_supplicant makes it really easy to configure wifi access.  Create a
wpa_supplicant config file in /etc/wpa_supplicant/wpa_supplicant.conf
 with the following contents, changing the values for
your access point accordingly.

```
network={
    ssid="MYHOME_WIFI"
    psk="verysecretpassword"
    key_mgmt=WPA-PSK
}
```

If you configure the wpa_supplicant config file and the Pi can't connect to your
access point try using the wpa_passphrase program to generate an encrypted psk
key e.g.
```
wpa_passphrase MYHOME_WIFI verysecretpassword
```

The output is the wpa_supplicant configuration to connect to your access point
with the given SSID and password e.g.
```
network={
	ssid="MYHOME_WIFI"
	#psk="verysecretpasswd"
	psk=6db108af12b7aac3e5859129608fcd19b8c775faa4b3a669e96d5fd14b02f8bf
}
```

A command to do it all in one is

```
wpa_passphrase MYHOME_WIFI verysecretpassword | sudo cat - > /etc/wpa_supplicant/wpa_supplicant.conf
```

### Download the installation scripts

Create a directory for the installation, change into the new directory and clone
the git repo.

```
sudo mkdir /home/smartboatnetwork
sudo chown pi.pi /home/smartboatnetwork
cd /home/smartboatnetwork
git clone https://github.com/SmartBoatNetwork/raspberry_pi
```

### Run the install scripts

You now have a collection of scripts to remove a load of crud and install the
goodies.  There is a single install script that will run all of the scripts
but you are probably better off looking at each script and deciding if you
want to run it, for example Samba File Sharing (Windows file sharing) is optional
and you may not want to install OpenCPN if all you want is an NMEA multiplexer
and SignalK server.  You can run all the scripts with

```
cd raspberry_pi/setup_scripts
bash ./install.sh
```

#### strip the pi of clutter

The desktop version of Raspbian comes with some games and a lot of other stuff
you aren't going to need.  Games ?  who has time to play games - we are serious
sailors here...
```
bash ./strip_pi.sh
```

#### install essential things
There are a 2 scripts that are essential and should be installed, everything
else is optional.

```
bash ./install_essential.sh
bash ./install_signalk.sh
```

At the end of the signalk install process a configuration script will run and
ask you if you want to use port 80 rather than port 3000.  We have configured
signalk-server-node to run on port 4000.  It will also ask you for
the name of your boat.

#### install vnc server

VNC is a useful tool if you intend to run OpenCPN as it will allow you to view
the desktop of the Pi on another device, including mobile tablets.  Note that
you need to enable VNC in raspi_config.

```
bash ./install_vnc.sh
```

#### enable ssh etc

Use raspi_config.

#### start signalk-server-node on boot

The SignalK install script should have enabled the SignalK to start at boot.
You can check if it will be successful by changing directory to the signalk folder
and starting the script manually.  The name of the script is based on your boat
name and is located in the bin folder of signalk-server-node e.g.  OceanWave will be
/home/smartboatnetwork/signalk-server-node/bin/OceanWave and 'Jimminy Cricket' will be
/home/smartboatnetwork/signalk-server-node/bin/Jimminy_Cricket.

```
cd /home/smartboatnetwork/signalk-server-node
bin/OceanWave (or whatever your boat name is)
```

The output should be
```
No settings/defaults.json available
signalk-server running at 0.0.0.0:4000
```

#### install OpenCPN

Install OpenCPN with
```
bash ./install_opencpn.sh
```
After installation start OpenCPN and add a connection to SignalK NMEA port.
Open the Connections section of OpenCPN settings and click *Add Connection*.
Select Network connection radio button
Protocol: TCP
Address: 0.0.0.0
DataPort: enter 10110 (10110 is the assigned port number for NMEA data and
  signalK provides the NMEA data stream on this port)
Check Control checksum
Input filtering: Select Ignore sentences radio button and leave the list blank
Output filtering: select Drop sentences radio button and leave the list blank

## Configuration API

A principle goal of this project is to provide an API so that the Pi can be
configured by client applications.  The things we hope to achieve are similar
to that provided by the openplotter project but using Node.JS as the programming
language rather than python and using the SignalK server as the API server.

#### configure kplex and signalk
```
bash ./install_kplex.sh
```

#### NMEA 0183 Multiplexer

Multiplex and filter data inputs and outputs.

#### monitor gpio pins

e.g. with https://github.com/paulvarache/node-gpio

#### i2c bus

#### 1w

#### WiFi Access Point

Configure the Pi as a Wifi access point so we can share data
(NMEA 0183, Signal K, remote desktop, Internet) with laptops, tablets and phones.
This script configures a wifi access point with the SSID of SmartBoat and a password
of SmartBoatNetwork
```
bash ./install_wifi_ap.sh
```

#### Data filter

Check the data traffic to avoid conflicts and overlaps between sources

#### SDR-AIS

Install programs to get AIS data via a USB SDR-RTL dongle
```
bash ./install_ais.sh
```
see: [RTL-SDR AIS reciever](https://www.rtl-sdr.com/setting-up-a-raspberry-pi-based-ais-receiver-with-an-rtl-sdr/)


#### satellite weather

You will need a RTL-SDR USB dongle and an appropriate (e.g. QFA) antenna.
```
bash ./install_weathersat.sh
```

see:
[Satellite Weather Stations](https://www.rtl-sdr.com/setting-up-an-rtl-sdr-based-aptmeteor-satellite-weather-stations/)
[Weather Satellite Images](https://www.rtl-sdr.com/rtl-sdr-tutorial-receiving-noaa-weather-satellite-images/)
[Decoding Meteor M2 weather satellite images](https://www.rtl-sdr.com/rtl-sdr-tutorial-decoding-meteor-m2-weather-satellite-images-in-real-time-with-an-rtl-sdr/)

#### Zygrib

Install Zygrib
TODO: get zygrib data for location
```
bash ./install_zygrib.sh
```
