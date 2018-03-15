source /home/smartboatnetwork/raspberry_pi/setup_scripts/config.sh

sudo apt-get -y libfreeimage-dev

cp ${sources}/imgkap.c ${tmp}

cd ${tmp}

gcc -I./FreeImage/Source/ imgkap.c -O3 -s -lm -lfreeimage -o ${bin}/imgkap
