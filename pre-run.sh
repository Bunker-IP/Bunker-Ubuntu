#!/bin/bash

echo "We going to install, dig, whois, net-tools, ufw, build-essential";
sudo apt install dig whois net-tools ufw build-essential
echo "";
echo "All Done! You can run Bunker-IP now!";
#This script only need to be run 1 time, don't need to re-install it all the time.
echo "We going to remove PRE-RUN.sh Script";
sudo rm -rf pre-run.sh
exit
