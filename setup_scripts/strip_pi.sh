
# Edu-related packages
pkgs="$pkgs
idle python3-pygame python-pygame python-tk
idle3 python3-tk
python-picamera python3-picamera
python3-pygame python-pygame python-tk
python3-tk
dillo x2x
scratch nuscratch
timidity
smartsim penguinspuzzle
pistore
sonic-pi
python3-numpy
python3-pifacecommon python3-pifacedigitalio python3-pifacedigital-scratch-handler python-pifacecommon python-pifacedigitalio
minecraft-pi python-minecraftpi
wolfram-engine
libreoffice
libreoffice-draw
libreoffice-math
bluej
geany
greenfoot
scratch2
chromium-browser
claws-mail
"

# Remove packages
for i in $pkgs; do
	echo apt-get -y remove --purge $i
done

# Remove all packages for libreoffice
dpkg --list |grep "libreoffice" | cut -d " " -f 3 | xargs apt-get -y remove --purge

# Remove automatically installed dependency packages
echo apt-get -y autoremove


# Remove all packages marked rc (thanks @symm)
dpkg --list |grep "^rc" | cut -d " " -f 3 | xargs dpkg --purge

pkgs="
 mmake
 libecj-java-gcj
 libecj-java
 java-policy
 ecj
 ikvm
 gcj-6-jdk
 gcj-5-jdk
 gcj-4.9-jdk
 gcj-4.8-jdk
 gcj-4.4-jdk
 eclipse-platform
 default-jre-headless
 java-policy
  openjdk-8-jre-headless
oracle-java8-jdk
"

# Remove all java related packages
for i in $pkgs; do
	echo apt-get -y remove --purge $i
done


# Remove automatically installed dependency packages
echo apt-get -y autoremove

pkgs="cups-bsd
epiphany-browser
gcc
g++
gdb
java-common
netsurf-gtk
poppler-data
poppler-utils"

# Remove packages with confirmation
for i in $pkgs; do
	echo apt-get -y remove --purge $i
done


# Remove automatically installed dependency packages
echo apt-get -y autoremove
