#!/bin/bash

# Colors
BLUE="\e[34m"
RESET="\e[0m"
GREY="\e[90m"
RED="\e[31m"

# User interface for monitroring and managing users on the system
userInterface() {
	clear
	showheader
	echo -e "${GREY}Current user on system: ${RESET}\n$(lslogins -u) ${GREY}\nCurrently logged in: \n${RESET}$(who)\n$(pwd)"
	echo -e "${BLUE}++++++++++++++++++++++++++++ ${RESET}"
	
	while true; do
		read -p "$(whoami):UI > " user_input

		case "$user_input" in
			"list all"|list|la)
			lslogins
			;;
			exit|quit|"main menu")
			mainMenu
			;;
			"exit!"|"quit!")
			exit
			;;
			clear|cls)
			clear
			userInterface
			;;
			*)
			echo -e "${RED}Unkown command. Try \"help\" to see all available commands.${RESET}"
			;;
		esac
	done
}

# Hardware interface for monitoring and managing the systems hardware
hardwareInterface() {
	clear
	showheader
	echo "Hardware Interface"
	mainMenu
}

# FM interface for intuitively  monitoring, managing and manipulating files 
fmInterface() {
	clear
	showheader
	echo "File Manager Interface"
	mainMenu
}

# Header
showheader() {
	echo -e "${BLUE}  ____ ___  _ ____ _ "
	echo '/ ___\\  \/// ___\/ \'
	echo '|    \ \  / |    \| |'
	echo -e  "\___ | / /  \___ || | ${GREY}Time: ${RESET} $(date +%T)"
	echo -e "${BLUE}\____//_/   \____/\_/ ${GREY}Date: ${RESET} $(date +%D)"
	echo -e "${BLUE}++++++++++++++++++++++++++++"

}

commandMode() {
	clear
	showheader
	echo -e "${RED}COMMAND MODE${RESET}\n$(pwd)"
	echo -e "${BLUE}++++++++++++++++++++++++++++ ${RESET}"
	
	while true; do
		echo -en "$(whoami)${RED}:CM${RESET} > "
		read user_input

		if [ "$user_input" = "quit" ] || [ "$user_input" = "exit" ]; then
			mainMenu
	      	elif [ "$user_input" = "quit!" ] || [ "$user_input" = "exit!" ]; then
		      	exit
		elif [ "$user_input" = "clear" ] || [ "$user_input" = "cls" ]; then
		      	clear
			commandMode
		else 
			eval $user_input
		fi
	done
}


# Main menu
mainMenu() {
	clear
	showheader
	kernel_version=$(uname -r)
	os_name=$(grep -w "NAME=" /etc/os-release | cut -d'"' -f2)
	os_version=$(grep -w "VERSION=" /etc/os-release | cut -d'"' -f2)
	os_info="$os_name $os_version"
	echo -e "${GREY}Operating system: ${RESET}$os_info ${GREY}Kernel Version: ${RESET}$kernel_version\n$(pwd)"
	echo -e "${BLUE}++++++++++++++++++++++++++++ ${RESET}"

	while true; do
		read -p "$(whoami) > " user_input
		read -r first rest <<< $user_input
		if [ "$first" = "CMD" ]; then
			eval $rest	
		else 
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
				"CM!"|"command mode")
				commandMode
				;;
				exit|quit)
				echo Ciao Cacao!
				exit
				;;
				clear|cls)	
				clear
				mainMenu
				;;
				*)
				echo -e "${RED}Unkown command. Try \"help\" to see all available commands.${RESET}"
			esac
		fi
	done	
}

mainMenu
