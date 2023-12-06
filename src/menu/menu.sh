#!/bin/bash

# Bunker-[IP] Main Menu > Options
displayMainMenu() {
    echo ""
    echo ${GREEN}"Bunker-[IP] Main Menu ${NORMAL}"
    echo "----------------------------------------------------"
    echo "${GREEN}[1]${NORMAL} Bunker-[IP]"
    echo "${GREEN}[2]${NORMAL} Bunker Firewall"
    echo "${GREEN}[3]${NORMAL} Bunker Apache2 Web Server"
    echo "${GREEN}[4]${NORMAL} Bunker Nginx Web Server"
    echo "${GREEN}[5]${NORMAL} Bunker Bootstrap5 Templates"
    echo "----------------------------------------------------"
    echo "${RED}[9]${NORMAL} Exit"
    echo ""
}

# Bunker-[IP] SubMenu #1 >  Options
displaySubmenu1() {
    echo ""
    echo "${GREEN}Bunker-[IP] MENU${NORMAL}"
    echo "-------------------------------------------------------------------"
    echo "${GREEN}[1]${NORMAL} Search  | IP Address Search RBL"
    echo "${GREEN}[2]${NORMAL} Add     | -add     - Add URL RBL in Bunker"
    echo "${GREEN}[3]${NORMAL} Bunker  | -bunker  - Display IP Bunker List"
    echo "${GREEN}[4]${NORMAL} Check   | -check   - Display Bunker RBL List"
    echo "${GREEN}[5]${NORMAL} Delete  | -delete  - Delete Bunker URL RRL List"
    echo "${GREEN}[6]${NORMAL} Version | -version - Bunker IP Version"
    echo "-------------------------------------------------------------------"
    echo "${RED}[9]${NORMAL} < Go Back"
    echo ""
}
# Display Bunker-[IP] Firewall Menu
displaySubmenu2() {
    echo ""
    echo "${GREEN} Bunker-[IP] MENU Firewall${NORMAL}"
    echo "---------------------------------------------------------"
    echo "${GREEN}[1]${NORMAL} Status"
    echo "${GREEN}[2]${NORMAL} Delete"
    echo "${GREEN}[3]${NORMAL} Manual Add IP"
    echo "${GREEN}[4]${NORMAL} Auto Insert IP.Bunker in UFW"
    echo "---------------------------------------------------------"
    echo "${RED}[9]${NORMAL} < Go Back"
    echo ""
}

displaySubmenu3() {
    echo ""
    echo "${GREEN}Bunker-[IP] MENU Web Server${NORMAL}"
    echo "-------------------------------------------------------"
    echo "${GREEN}[1]${NORMAL} Install Apache2"
    echo "${GREEN}[2]${NORMAL} Install Vhost/Domain"
    echo "${GREEN}[3]${NORMAL} Normal Web HTML5/CSS3"
    echo "${GREEN}[4]${NORMAL} Clone Bootstrap5 Web Template"
    echo "${GREEN}[5]${NORMAL} Check Sites DIR"
    echo "${GREEN}[6]${NORMAL} Install Certbot SSL"
    echo "${GREEN}[7]${NORMAL} Run Web Server HTTPS"
    echo "${GREEN}[8]${NORMAL} Delete WebSite from Server"
    echo "-------------------------------------------------------"
    echo "${RED}[9]${NORMAL} < Go Back"
    echo ""
}

#Bunker-[IP] - Nginx Web Server Menu
displaySubmenu4() {
    echo "-------------------------------------------------------------------"
    echo "${RED}Bunker-[IP] - NNGINX SOON${NORMAL}"
    echo "-------------------------------------------------------------------"

 }

#Bunker-[IP] - MultiSites Templates with Bootstrap 5
displaySubmenu5() { 
    echo ""
    echo "${GREEN}Bunker-[IP] MultiSites Templates with Bootstrap5${NORMAL}"
    echo "-------------------------------------------------------------------"
    echo "${GREEN}[1]${NORMAL} CaterServ   - Business Landing"
    echo "${GREEN}[2]${NORMAL} HeroBiz     - Business Template"
    echo "${GREEN}[3]${NORMAL} Furni       - Business & Corporate"
    echo "${GREEN}[4]${NORMAL} Haimic      - Business & Corporate"
    echo "${GREEN}[5]${NORMAL} High TechIT - IT Solutions Website"
    echo "${GREEN}[6]${NORMAL} MiniStore   - E-Commerce Website"
    echo "${GREEN}[7]${NORMAL} NiceAdmin   - Admin DashBoard"
    echo "${GREEN}[8]${NORMAL} Peskit      - Pest Control Business"
    echo "-------------------------------------------------------------------"
    echo "${RED}[9]${NORMAL} < Go Back"
    echo ""
}
# Function to handle the submenu option

enterIPAddress() { 
    # Enter IP Address
    echo ${GREEN}"Enter IP Address: ${NORMAL}";
    read ipAddress
}
enterURL() { 
    # Enter URL RBL Address
    echo ${GREEN}"Enter URL RBL Address: ${NORMAL}";
    read url        
}
certBotURL() { 
    # Enter domain name for certbot HTTPS/SSL
    echo ${GREEN}"Enter a domain name for cerbot: ${NORMAL}";
    read url        
}
webURL() { 
    # Enter a domain name for webserver
    echo ${GREEN}"Enter a domain name for WebServer: ${NORMAL}";
    read url        
}
deleteURL() { 
    # Enter URL RBL Address for Delete
    echo ${GREEN}"Enter URL RBL Address: ${NORMAL}";
    read url        
}
deleteURLApache(){
    # Enter Domain for remove web server with apache2
    echo ${GREEN}"Enter a Domain for remove Web Serv: ${NORMAL}";
    read url   
}
templateURL() {
    #This install Template from Bootstrap 5 Themes in  your WebSite.
    echo ${GREEN}"Enter a Domain for install Bootstrap 5 Template: ${NORMAL}";
    read url   
}
# Function to handle user input 
## Execute the selected option.
handleUserInput() {
    local choice="$1"
    case "$choice" in
        1)
            displaySubmenu1
            read -p "Enter your choice: " submenu1Choice
            handleSubmenu1Input "$submenu1Choice"
            ;;
        2)
            displaySubmenu2
            read -p "Enter your choice: " submenu2Choice
            handleSubmenu2Input "$submenu2Choice"
            ;;
        3)
            displaySubmenu3
            read -p "Enter your choice: " submenu3Choice
            handleSubmenu3Input "$submenu3Choice"
            ;;
        4)
            displaySubmenu4
            read -p "Enter your choice: " submenu3Choice
            handleSubmenu4Input "$submenu3Choice"
            ;;
        5)
            displaySubmenu5
            read -p "Enter your choice: " submenu3Choice
            handleSubmenu5Input "$submenu3Choice"
            ;;
        6)
            displaySubmenu6
            read -p "Enter your choice: " submenu3Choice
            handleSubmenu6Input "$submenu3Choice"
            ;;
        9)
            clear
            echo ${GREEN}"Exiting...${NORMAL}"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
}
# Function to handle submenu 1 user 
## Input and execute the selected option.
handleSubmenu1Input() {
    local choice="$1"
    
    case "$choice" in
        1)
        #Bunker Search for Match IP in the RBL List.
         enterIPAddress
         if [ -z "$ipAddress" ]
        then
            echo ${RED}"Need to enter a IP Address for search"${NORMAL} ;
            exit 1
        fi
            sh ./src/rbl/rbl.sh ${ipAddress}
		exit;;
        2) #Add URL RBL In bunker for scan 
        enterURL
        if [ -z "$url" ]
        then
            echo ${RED}"Need to enter a URL for add in bunker"${NORMAL} ;
            exit 2
        fi
        if cat ./bunker/rbl-list.bunker | tr "," " " | grep -xqF $url; then
        echo "";
		echo ${NORMAL}" RBL Domain:" ${YELLOW} $url ${NORMAL} "Exists in ${YELLOW}rbl-list.bunker ${NORMAL}";
        echo ""
		else
		echo "";
		echo "${GREEN}Going to add a RBL Domain in ${YELLOW}rbl-list.bunker ${NORMAL}";
        echo $url >> ./bunker/rbl-list.bunker;
        echo "";
        echo "${GREEN}The RBL Domain add in list is: ${YELLOW} $url ${NORMAL}";
        echo "";
        echo ""
		fi
		    exit;;
        3) # Check RBL List Bunker and Show list
            echo ${NORMAL}"-----------------";
            echo ${GREEN}" IP Bunker List ";
            echo ${NORMAL}"-----------------";
            cat -n ./ip/ip.bunker | more ;
            exit;;
        4) # Check RBL List Bunker and Show list
            echo ${NORMAL}"-----------------";
            echo ${GREEN}" RBL List Bunker ";
            echo ${NORMAL}"-----------------";
            cat -n  ./bunker/rbl-list.bunker;
            exit;;
        5)
        deleteURL
	  	if [ -z "$url" ]
		then
            echo ${RED}"Need to enter a URL for delete in bunker"${NORMAL}
            exit 5
                fi
            grep -F -v $url ./bunker/rbl-list.bunker > ./bunker/rbl-list.bunker.tmp && 
            mv ./bunker/rbl-list.bunker.tmp ./bunker/rbl-list.bunker;
            echo "";
            echo "The RBL url delete in ${YELLOW}rbl-list.bunker ${NORMAL}is:" ${GREEN} $url ${NORMAL}; 
            echo "";
            exit;;
        6) # Display Bunker-[IP] Running Version
            echo "-------------------------";
            echo "";
             cat ./src/version/vBunkerIP.bunker
            echo "";
            echo "-------------------------";
            ;;
        9)
            displayMainMenu
            read -p "Enter your choice: " mainMenuChoice
            handleUserInput "$mainMenuChoice"
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
}
# Function to handle submenu 2 user input and execute the selected option.
handleSubmenu2Input() {
    local choice="$1"

    case "$choice" in
        1)
        echo "${YELLOW}"BUNKER-[IP] UFW Status"${NORMAL};"
        cat ./ip/ufw.status.bunker | grep "DENY IN" | more
		echo "";
		echo ${GREEN}"This status only show DENY IN IP Address.";
		echo ${NORMAL}"If you want check your UFW Status run in command terminal.";
        ;;
        2)
        enterIPAddress
        if [ -z "$ipAddress" ]
		then
		echo ${RED}"Need to enter a IP for delete in IP bunker "${NORMAL}
		exit 2
			fi
		grep -F -v $ipAddress ./ip/ip.bunker > ./ip/ip.bunker.tmp && 
		mv ./ip/ip.bunker.tmp ./ip/ip.bunker;
		echo "";
		echo ${YELLOW}"The IP Address delete in ip.bunker is:" ${NORMAL} $ipAddress ; 
		echo "This is the rule numbered in your firewall.";
		sudo ufw status numbered | grep $ipAddress
		echo ""
		echo ${GREEN}
		sudo ufw delete deny from $ipAddress
		echo ${NORMAL}
        exit;;

        3) #Insert a single IP address in ip.bunker
        # this ip can be or not a match on a RBL system.
        # This is because you add manual and no scan with Bunker-[IP]
        enterIPAddress
        if [ -z "$ipAddress" ]
		then
		echo ${RED}"Enter a single IP Address to add in ip.bunker List "${NORMAL}
		exit 3
			fi
        echo "${GREEN}Going to add a single IP Address in ip.bunker ${NORMAL}";
        if cat ./ip/ip.bunker | tr "," " " | grep -xqF $ipAddress; then
        echo "";
		echo ${NORMAL}" IP Address:" ${YELLOW} $ipAddress ${NORMAL} "Exists in ip.bunker";
        echo "";
        fi
		echo "";
        echo $ipAddress >> ./ip/ip.bunker
        echo "${GREEN}The ip add in list is: ${YELLOW} $ipAddress ${NORMAL}";
        echo "";
        echo "${YELLOW} This ip you add is not scan with Bunker-[IP] RBL System ${NORMAL}"
        echo "";
        echo "${GREEN} This ip: ${YELLOW} $ipAddress ${GREEN} you add can be or not a positive match in rbl${NORMAL}"
        echo "";
		exit;;

        4) # This add all the ip.bunker list into the firewall DENY ALL table
         echo "${GREEN}Going to all ip.bunker List in to UFW..."
         echo "${YELLOW}This can take some time ${NORMAL}";
         echo "";
            for IP in $(cat ./ip/ip.bunker); do
                sudo ufw insert 1 deny  from $IP
            done
        echo "";
        ;;
        9)
            displayMainMenu
            read -p "Enter your choice: " mainMenuChoice
            handleUserInput "$mainMenuChoice"
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
}
# Function to handle submenu 3 user input and execute the selected option.
handleSubmenu3Input() {
    local choice="$1"

    case "$choice" in

        1) #Install Apache2 Web Server
        echo ${GREEN}"Installing Apache2 In your Server.${NORMAL}"
        sudo apt install apache2 -y
        exit;;

        2) #Install Apache2 Vhost/Domain
        webURL
        if [ -z "$url" ]
        then
        echo ""
        exit 2
        fi
        echo "Creating Directory"
        sudo mkdir /var/www/html/$url
        sudo mkdir /var/www/html/$url/public_html
        echo ${YELLOW}"Creating Index in directory ${NORMAL}";
        sudo chown -R ${USER}:${USER} /var/www/html/$url/public_html
        echo "Creating vhost in /etc/apache2/sites-available";
		cd /etc/apache2/sites-available
		echo ${YELLOW}"Setting controllers for file edition.${NORMAL}";
		sudo touch $url.conf
		sudo chown -R ${USER}:${USER} $url.conf
		echo ${GREEN}"Creating Vhost Domain Configuration ${NORMAL}";
        echo "
<VirtualHost *:80>
	ServerName $url
	ServerAlias www.$url
	ServerAdmin admin@$url
	DocumentRoot /var/www/html/$url/public_html/
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
	RewriteEngine on
	RewriteCond %{SERVER_NAME} =$url
	RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
</VirtualHost> " > $url.conf
		sudo a2ensite $url.conf
		echo ${YELLOW}"Restarting Apache2 Web Server ${NORMAL}"
		sleep 3;
		sudo systemctl reload apache2
		echo ${YELLOW} "Your website is running on: ${GREEN} http://$url ${NORMAL}";
		exit;;	
        3) #Install Normal HTML5/CSS3 WEB
        webURL
        if [ -z "$url" ]
        then
        echo ""
        exit 3
        fi
        echo "${GREEN} Going to create a HTML5/CSS3 Static WEB ${NORMAL}"
        echo "";
        sudo rm -rf /var/www/html/$url/public_html && sudo cp -R ./src/multisites/web-html /var/www/html/$url/public_html

        echo "";
        echo "${GREEN} You can check your website in http://$url ${NORMAL}"
        exit;;
        
        4) #Clone Bootstrap5 Template Web
        webURL
        if [ -z "$url" ]
        then
        echo ""
        exit 4
        fi
        echo "${GREEN} Going to create a Bootstrap 5 Template ${NORMAL}"
        echo "";
        sudo rm -rf /var/www/html/$url/public_html && sudo cp -R ./src/multisites/web-bootstrap /var/www/html/$url/public_html

        echo "";
        echo "${GREEN} You can check your website in http://$url or https://$url ${NORMAL}"
        exit;;
        
        5) #Check all the WebSite Running
        echo "${YELLOW}Check all Domain in system ${NORMAL}";
        ls /var/www/html
        exit;;

        6) # Add Certbot to your server
        echo "${YELLOW} Installing Certbot for Apache2 ${NORMAL}";
         sudo apt install certbot python3-certbot-apache
        echo "";
        exit;;

        7) # Installing HTTPS Web Server in Apache2
        certBotURL
        if [ -z "$url" ]
        then
        echo "${RED}Need to enter Domain to install SSL Certificated ${NORMAL}"
        exit 7
        fi
        echo "${YELLOW} Installing Certbot for Apache2 ${NORMAL}";
         sudo certbot --apache -m admin@$url -d $url -d www.$url
        echo "";
        exit;;

        8)
        deleteURLApache
        if [ -z "$url" ]
        then
        echo "${RED}Need to enter Domain to remove Web Server ${NORMAL}"
        exit 8
        fi
        echo "${YELLOW} Remove Web Server from: ${GREEN} $url ${NORMAL}";
        sudo rm -rf /var/www/html/$url
        cd /etc/apache2/sites-available/
        sudo a2dissite $url.conf
        sudo service apache2 restart
        echo ${GREEN}"WAIT! Rebooting Apache2..."
        sleep 3
        echo "${GREEN}Domain is clear and you can configure again in your system.";
        echo "${YELLOW} You can use again: ${GREEN} $url ${NORMAL}"
        sleep 5
        exit;;

        9)
            displayMainMenu
            read -p "Enter your choice: " mainMenuChoice
            handleUserInput "$mainMenuChoice"
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
}

#Bunker-[IP] - Nginx Menu Web Server
 handleSubmenu4Input() {
    local choice="$1"
     case "$choice" in
        
    esac
}

#Bunker-[IP] - Bootstrap 5 Web's Template
handleSubmenu5Input() {
    local choice="$1"
    case "$choice" in
    ## All this templates are CopyRights and got all info inside of .zip
    ## Bunker-[IP] Just run the templates for you and install it in your website.
    ## Each Template got a code by. Check DOC/README on Install.

    1) #Bunker-[IP] Template - Bootstrap 5 : CaterServ-1.0.0.zip
    clear
    templateURL
    if [ -z "$url" ]
        then
         echo "${RED} Enter a Domain for install the Template ${NORMAL}"
         exit 1
        fi
         echo "${GREEN} Going to create a Bootstrap 5 Template: ${YELLOW} CaterServ ${NORMAL}"
		 echo "";
		 sudo cp -R ./src/multisites/templates/CaterServ /var/www/html/$url/ &&
         cd /var/www/html/$url/ &&
         sudo chown -R ${USER}:${USER} CaterServ && 
         sudo chmod 755 CaterServ &&
         sudo rm -rf public_html &&
         sudo mv CaterServ public_html &&
         sudo find /var/www/html/$url/ -type d -exec chmod 755 {} \; &&
         sudo find /var/www/html/$url/ -type f -exec chmod 644 {} \; 
         echo "${GREEN}Your Template: ${YELLOW}CaterServ ${NORMAL} is created.";
         sleep 2;
         echo "${GREEN}You can check your web in: ${YELLOW}http://$url ${NORMAL} or ${YELLOW} https://$url ${NORMAL}";
    ;;

    2) #Bunker-[IP] Template - Bootstrap 5 : HeroBiz-1.0.0.zip
    clear
    templateURL
    if [ -z "$url" ]
        then
         echo "${RED} Enter a Domain for install the Template ${NORMAL}"
         exit 2
        fi
         echo "${GREEN} Going to create a Bootstrap 5 Template: ${YELLOW} HeroBiz ${NORMAL}"
		 echo "";
		 sudo cp -R ./src/multisites/templates/HeroBiz /var/www/html/$url/ &&
         cd /var/www/html/$url/ &&
         sudo chown -R ${USER}:${USER} HeroBiz && 
         sudo chmod 755 HeroBiz &&
         sudo rm -rf public_html &&
         sudo mv HeroBiz public_html &&
         sudo find /var/www/html/$url/ -type d -exec chmod 755 {} \; &&
         sudo find /var/www/html/$url/ -type f -exec chmod 644 {} \; 
         echo "${GREEN}Your Template: ${YELLOW}HeroBiz ${NORMAL} is created.";
         sleep 2;
         echo "${GREEN}You can check your web in: ${YELLOW}http://$url ${NORMAL} or ${YELLOW} https://$url ${NORMAL}";
    ;;

    3) #Bunker-[IP] Template - Bootstrap 5 : Furmi-1.0.0.zip
    clear
    templateURL
    if [ -z "$url" ]
        then
         echo "${RED} Enter a Domain for install the Template ${NORMAL}"
         exit 3
        fi
         echo "${GREEN} Going to create a Bootstrap 5 Template: ${YELLOW} Furni ${NORMAL}"
		 echo "";
		 sudo cp -R ./src/multisites/templates/furni /var/www/html/$url/ &&
         cd /var/www/html/$url/ &&
         sudo chown -R ${USER}:${USER} furni && 
         sudo chmod 755 furni &&
         sudo rm -rf public_html &&
         sudo mv furni public_html &&
         sudo find /var/www/html/$url/ -type d -exec chmod 755 {} \; &&
         sudo find /var/www/html/$url/ -type f -exec chmod 644 {} \; 
         echo "${GREEN}Your Template: ${YELLOW}Furni ${NORMAL} is created.";
         sleep 2;
         echo "${GREEN}You can check your web in: ${YELLOW}http://$url ${NORMAL} or ${YELLOW} https://$url ${NORMAL}";
    ;;

    4) #Bunker-[IP] Template - Bootstrap 5 : hairnic-1.0.0.zip
    clear
    templateURL
    if [ -z "$url" ]
        then
         echo "${RED} Enter a Domain for install the Template ${NORMAL}"
         exit 4
        fi
         echo "${GREEN} Going to create a Bootstrap 5 Template: ${YELLOW} Hairnic ${NORMAL}"
		 echo "";
		 sudo cp -R ./src/multisites/templates/hairnic /var/www/html/$url/ &&
         cd /var/www/html/$url/ &&
         sudo chown -R ${USER}:${USER} hairnic && 
         sudo chmod 755 hairnic &&
         sudo rm -rf public_html &&
         sudo mv hairnic public_html &&
         sudo find /var/www/html/$url/ -type d -exec chmod 755 {} \; &&
         sudo find /var/www/html/$url/ -type f -exec chmod 644 {} \; 
         echo "${GREEN}Your Template: ${YELLOW}Hairnic ${NORMAL} is created.";
         sleep 2;
         echo "${GREEN}You can check your web in: ${YELLOW}http://$url ${NORMAL} or ${YELLOW} https://$url ${NORMAL}";
    ;;

    5) #Bunker-[IP] Template - Bootstrap 5 : HighTechIT-1.0.0.zip
    clear
    templateURL
    if [ -z "$url" ]
        then
         echo "${RED} Enter a Domain for install the Template ${NORMAL}"
         exit 5
        fi
         echo "${GREEN} Going to create a Bootstrap 5 Template: ${YELLOW} HighTechIT ${NORMAL}"
		 echo "";
		 sudo cp -R ./src/multisites/templates/HighTechIT /var/www/html/$url/ &&
         cd /var/www/html/$url/ &&
         sudo chown -R ${USER}:${USER} HighTechIT && 
         sudo chmod 755 HighTechIT &&
         sudo rm -rf public_html &&
         sudo mv HighTechIT public_html &&
         sudo find /var/www/html/$url/ -type d -exec chmod 755 {} \; &&
         sudo find /var/www/html/$url/ -type f -exec chmod 644 {} \; 
         echo "${GREEN}Your Template: ${YELLOW}HighTechIT ${NORMAL} is created.";
         sleep 2;
         echo "${GREEN}You can check your web in: ${YELLOW}http://$url ${NORMAL} or ${YELLOW} https://$url ${NORMAL}";
    ;;

    6) #Bunker-[IP] Template - Bootstrap 5 : MiniStore-1.0.0.zip
    clear
    templateURL
    if [ -z "$url" ]
        then
         echo "${RED} Enter a Domain for install the Template ${NORMAL}"
         exit 6
        fi
         echo "${GREEN} Going to create a Bootstrap 5 Template: ${YELLOW} MiniStore ${NORMAL}"
		 echo "";
		 sudo cp -R ./src/multisites/templates/MiniStore /var/www/html/$url/ &&
         cd /var/www/html/$url/ &&
         sudo chown -R ${USER}:${USER} MiniStore && 
         sudo chmod 755 MiniStore &&
         sudo rm -rf public_html &&
         sudo mv MiniStore public_html &&
         sudo find /var/www/html/$url/ -type d -exec chmod 755 {} \; &&
         sudo find /var/www/html/$url/ -type f -exec chmod 644 {} \; 
         
         echo "${GREEN}Your Template: ${YELLOW}MiniStore ${NORMAL} is created.";
         sleep 2;
         echo "${GREEN}You can check your web in: ${YELLOW}http://$url ${NORMAL} or ${YELLOW} https://$url ${NORMAL}";
    ;;

    7) #Bunker-[IP] Template - Bootstrap 5 : NiceAdmin-1.0.0.zip
    clear
    templateURL
    if [ -z "$url" ]
        then
         echo "${RED} Enter a Domain for install the Template ${NORMAL}"
         exit 7
        fi
         echo "${GREEN} Going to create a Bootstrap 5 Template: ${YELLOW} NiceAdmin ${NORMAL}"
		 echo "";
		 sudo cp -R ./src/multisites/templates/NiceAdmin /var/www/html/$url/ &&
         cd /var/www/html/$url/ &&
         sudo chown -R ${USER}:${USER} NiceAdmin && 
         sudo chmod 755 NiceAdmin &&
         sudo rm -rf public_html &&
         sudo mv NiceAdmin public_html &&
         sudo find /var/www/html/$url/ -type d -exec chmod 755 {} \; &&
         sudo find /var/www/html/$url/ -type f -exec chmod 644 {} \;
         echo "${GREEN}Your Template: ${YELLOW}NiceAdmin ${NORMAL} is created.";
         sleep 2;
         echo "${GREEN}You can check your web in: ${YELLOW}http://$url ${NORMAL} or ${YELLOW} https://$url ${NORMAL}";
    ;;

    8) #Bunker-[IP] Template - Bootstrap 5 : PestKit-1.0.0.zip
    clear
    templateURL
    if [ -z "$url" ]
        then
         echo "${RED} Enter a Domain for install the Template ${NORMAL}"
         exit 8
        fi
         echo "${GREEN} Going to create a Bootstrap 5 Template: ${YELLOW} PestKit ${NORMAL}"
		 echo "";
		 sudo cp -R ./src/multisites/templates/PestKit /var/www/html/$url/ &&
         cd /var/www/html/$url/ &&
         sudo chown -R ${USER}:${USER} PestKit && 
         sudo chmod 755 PestKit &&
         sudo rm -rf public_html &&
         sudo mv PestKit public_html &&
         sudo find /var/www/html/$url/ -type d -exec chmod 755 {} \; &&
         sudo find /var/www/html/$url/ -type f -exec chmod 644 {} \;
         echo "${GREEN}Your Template: ${YELLOW}PestKit ${NORMAL} is created.";
         sleep 2; 
         echo "${GREEN}You can check your web in: ${YELLOW}http://$url ${NORMAL} or ${YELLOW} https://$url ${NORMAL}";
    ;;

    9)
      displayMainMenu
      read -p "Enter your choice: " mainMenuChoice
      handleUserInput "$mainMenuChoice"
      ;;
    esac
}


# Main function to start the menu.

main() {
    while true; do
        displayMainMenu
        read -p "Enter your choice: " mainMenuChoice
        handleUserInput "$mainMenuChoice"
    done
}

# Start the menu.
main
