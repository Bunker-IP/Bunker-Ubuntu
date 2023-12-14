#!/bin/bash

echo "We going to install: dig, whois, net-tools, ufw, build-essential";

sudo apt install dig whois net-tools ufw build-essential

echo "";
echo "All packets are installet. You don't need to run this again!";
echo "";
echo "Going to remove pre-run.sh";

sudo rm -rf pre-run.sh
exit