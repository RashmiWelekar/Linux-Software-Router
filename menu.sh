#!/bin/sh
# A menu driven shell script sample template 
## ----------------------------------
# Step #1: Define variables
# ----------------------------------
EDITOR=vim
PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD='\033[0;0;39m'
 
# ----------------------------------
# Step #2: User defined function
# ----------------------------------
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

block_ip(){
	local ip
	read -p "Enter ip-adress  " ip
	iptables -A INPUT -s $ip -j DROP
	echo "the given $ip has been blocked"
	pause
}

block_ip_withport(){
	local ip
	local port
	read -p "Enter ip-adress" ip
	echo " Enter port no to block"
	read -p " 0. etho   1. eth1 " port
	if [$port = 0 ] 
	then
	iptables -A INPUT -i eth0 -s $ip -j DROP
	echo "The ip $ip has been blocked at port eth0"
	pause
	fi
	if [$port = 1] 
	then
	iptables -A INPUT -i eth1 -s $ip -j DROP
	echo "The ip $ip has been blocked at port echo1"
	pause
	fi
	service iptables save
		}
delete_rule(){
	local rule_no
	read -p "Enter rule number " rule_no
	iptables -D INPUT $rule_no

}
		   

show_addmenu(){
	echo "1 Block a specific ip"
	echo "2 Block a specific port for specific ip."
	local choices
	read -p "Enter choice [1-2] " choices
	case $choices in 
		1) block_ip ;;
		2) block_ip_withport ;;	
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}    
one(){
	echo "one() called"
	iptables -L -n --line-numbers
        pause
}
 
# function to display menus
show_menus(){
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"	
	echo " M A I N - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "1. List all Ip-tables rule"
	echo "2. Add a rule"
	echo "3. Delete a rule "
	echo "4. Exit "
}
# read input from the keyboard and take a action
# invoke the one() when the user select 1 from the menu option.
# invoke the two() when the user select 2 from the menu option.
# Exit when user the user select 3 form the menu option.
read_options(){
	local choice
	read -p "Enter choice [ 1 - 4] " choice
	case $choice in
		1) one ;;
		2) show_addmenu ;;
		3) delete_rule ;;
		4) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}
 
# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP
 
# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
 
	
	show_menus
	read_options
done

