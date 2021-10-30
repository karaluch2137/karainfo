#! /usr/bin/bash

# this function return amount of posts per pontyfikat on given board

red='\033[0;31m'
NC='\033[0m'

if [[ ! -z $1 ]];then
	if [ -z $2 ];then
		file="${0%/*}/page.addr"
		url=$(cat "$file")
		content=$(wget "$url/$1" -q -O -)
		raw_page=$(sed -n "/<ul class=\"rules\">/,/<\/ul>/p" <<< "$content") 
		parsed_posts=$(grep -o -P '(?<=zapostowaniu.">).*(?= post)' <<< "$raw_page")
		if [ "$parsed_posts" == '' ];then
			echo -e "${red}board does not exist or internet connection error occured${NC}"
		else
			echo "$parsed_posts"
		fi
	else
		echo -e "${red}this function takes only one argument${NC}"
	fi
else
	echo -e "${red}no board specified${NC}"
fi
