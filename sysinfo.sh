#!/bin/bash
echo ' ____ ___  _ ____  _ '
echo '/ ___\\  \/// ___\/ \'
echo '|    \ \  / |    \| |'
echo -e  "\___ | / /  \___ || | Time: $(date +%T)"
echo -e "\____//_/   \____/\_/ Date: $(date +%D)"
echo '++++++++++++++++++++++++++++'
os_name=$(grep -w "NAME=" /etc/os-release | cut -d'"' -f2)
os_version=$(grep -w "VERSION=" /etc/os-release | cut -d'"' -f2)
os_info="$os_name $os_version"
echo "Operating system: $os_info"
