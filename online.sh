#! /usr/bin/bash

#script for obtaining current online amount

red='\033[0;31m'
NC='\033[0m'

file="${0%/*}/online.addr"
url=$(cat "$file")
content=$(wget "$url" -q -O -)
if [ "$content" == '' ];then
	echo -e "${red}internet connection error occured${NC}"
else
	count=$( echo "$content" | cut -d\' -f2 ) 
	echo "$count"
fi
