#!/bin/bash
# Bunker-[IP]
# This is a RBL Search IP Address and Firewall Rules
# With Bunker-[IP] You make sure your system is secure with a RBL System.
# All the IP Address you Scan with Bunker-[IP] if is a positive match in the URL RBL go to a ip.bunker list.
# This ip.bunker list can be activate by firewall rules for deny all ip address in .bunker
# Bunker-[IP] made it easy! You can add new RBL URL and remove old ones
#
# Code by: y2k
# Contact: y2k@evilnet.org
# WEB: https://github.com/Bunker-IP
# Version: https://github.com/Bunker-IP/Bunker-Ubuntu
########################### [ HELP PANEL ] ###########################
. "./src/colors/colors.sh";
## ----- DNSBL URL Bunker File - DON'T Edit this! -----
DNSBL=$(awk -F ',' '{print $1}' ./bunker/rbl-list.bunker);
## ----- DNSBL URL Bunker File - DON'T Edit this! -----


ERROR() {
	echo "$0" ERROR: "$1" >&2
	exit 2
    }
	
echo "${RED}" 
## Check if you insert a ip address.
[ $# -ne 1 ] && ERROR "Please specify a single IP address!"

echo  "${NORMAL}"; 
 
reverse=$(echo "$1" |
	  sed -ne "s~^\([0-9]\{1,3\}\)\.\([0-9]\{1,3\}\)\.\([0-9]\{1,3\}\)\.\([0-9]\{1,3\}\)$~\4.\3.\2.\1~p")
 
if [ "x${reverse}" = "x" ] ; then
	echo "${RED}"; 
	## Check if you inser a real (valid) ip address.
	ERROR " '$1' This is NOT a valid IP address. \r\n Insert a real IP Address if you want to continue!"
		echo "${NORMAL}"; 
		exit 1
	fi

HostToIP() {
	## Fetch hostname or ip address to the rbl
	if ( echo "$host" | grep -q "[a-zA-Z]" ); then
		 IP=$(host "$host" | awk '/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ {print$NF}')
			 else
				IP="$host"
			 fi
}

Repeat() { 
	printf "%${2}s\n" | sed "s/ /${1}/g" 
}
	  #Reverse HOST from IP
	  REVERSE_DNS=$(dig +short -x "$1")

Reverse(){
	echo "$1" | awk -F. '{print$4"."$3"."$2"."$1}';
}
   #Check if the IP is listed or not in EvilNet DNSBL
Check() {
	result=$(dig +short -t a "$rIP"."$BL")
		if [ -n "$result" ]; then
	## Show Message in RED COLOR if the IP is listed on some RBL.
		echo "${RED} Is Listed :( in:"  "${YELLOW}" "$BL" "${RED} (IP Listed in: $result) ${NORMAL}";
	## Grep results from rbl.txt this list got info from ip: 127.0.0.2 and so on...
		egrep -i -w $result ./bunker/rbl-class.bunker
		# Check if the ip is in ip.bunker
		# If the ip is on the rbl, add in a ip.bunker for
		if cat ./ip/ip.bunker | tr "," " " | grep -xqF $IP; then
		echo ${NORMAL}" IP Address:" ${YELLOW} $IP ${NORMAL} "Exists in ip.bunker";
		else
		echo $IP >> ./ip/ip.bunker
		echo "";
		fi
		else
	## Show Message in green if the ip is not listed on the RBL.
		echo "${GREEN} DNSBL: ${YELLOW}" "$BL ${GREEN}Not Listed :)" ${NORMAL};
		fi
}

if [ -n "$1" ]; then
	hosts=$*
 	fi

if [ -z "$hosts" ]; then
	hosts=$(netstat -tn | awk '$4 ~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ && $4 !~ /127.0.0/ {gsub(/:[0-9]+/,"",$4);} END{print$4}')
	fi

for host in $hosts; do
	HostToIP
	rIP=$(Reverse "$IP")
 	#echo; Repeat - 100
## Check for IP Address and Hostname repeat - 100 time to make some style :) just for make it nice!
## You can change the Repeat - 100 results for the value you need for make lines repeat. ------ 
	echo  "${YELLOW}" "Your" IP "Address is:" "${NORMAL}" "$IP"  "${YELLOW}" "\t Your" HOST "is:" "${NORMAL}" "${REVERSE_DNS}"
 	Repeat - 100
## Finish all info from all RBL / DNSBL list.
			for BL in $DNSBL; do
		Check
	done
done

echo "";
