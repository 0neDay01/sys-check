#!/bin/bash

# Colors
BLUE="\e[34m"
RESET="\e[0m"
GREY="\e[90m"
RED="\e["

# User interface for monitroring and managing users on the system
userInterface() {
	clear
	showheader
	lslogins -u 
	echo 
	who
	echo
	
	while true; do
		read -p "$(whoami) >" user_input

		case "$user_input" in
			"list all"|list|la)
			lslogins
			;;
			exit|quit|"main menu")
			userInput
			;;
			"exit!"|"quit!")
			exit
			;;
			*)
			echo -e "Unkown command. Try \"help\" to see all available commands.  "
			;;
		esac
	done
}

# Hardware interface for monitoring and managing the systems hardware
hardwareInterface() {
	clear
	showheader
	echo "Hardware Interface"
	userInput
}

# FM interface for intuitively  monitoring, managing and manipulating files 
fmInterface() {
	clear
	showheader
	echo "File Manager Interface"
	userInput
}

# Header
showheader() {
	echo -e "${BLUE}  ____ ___  _ ____ _ "
	echo '/ ___\\  \/// ___\/ \'
	echo '|    \ \  / |    \| |'
	echo -e  "\___ | / /  \___ || | ${GREY}Time: ${RESET} $(date +%T)"
	echo -e "${BLUE}\____//_/   \____/\_/ ${GREY}Date: ${RESET} $(date +%D)"
	echo -e "${BLUE}++++++++++++++++++++++++++++"
	kernel_version=$(uname -r)
	os_name=$(grep -w "NAME=" /etc/os-release | cut -d'"' -f2)
	os_version=$(grep -w "VERSION=" /etc/os-release | cut -d'"' -f2)
	os_info="$os_name $os_version"
	echo -e "${GREY}Operating system: ${Reset}$os_info ${GREY}Kernel Version: ${RESET}$kernel_version"
	echo -e "${BLUE}++++++++++++++++++++++++++++ ${RESET}"
}

# User input while TRUE
userInput() {
	clear
	showheader
	while true; do
		read -p "$(whoami) > " user_input
	
		case "$user_input" in
			user|users|login|logins)
			userInterface
			;;
			hardware|"check hardware"|specs|hw)
			hardwareInterface
			;;
			files|"file management"|fm)
			fmInterface
			;;
			exit|quit)
			echo Ciao Cacao!
			exit
			;;
			*)
			echo -e "Unkown command. Try \"help\" to see all available commands.  "
		esac
	done	
}

userInput
