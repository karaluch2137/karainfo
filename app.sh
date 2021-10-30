#! /usr/bin/bash
export TERM=linux

# app for displaying site info 

# arguments --board=[board] --loop=[true/false] --delay=[delay (s)] 
# default --board=b --loop=false --delay=5


function cleanup() {
    tput cnorm
}



b_arg="b"
r_arg="false"
d_arg="5"
l_arg="false"
w_arg='none'

first_time="true"

red='\033[0;31m'
gray='\033[0;37m'
NC='\033[0m'
bold='\e[1m'

while [ $# -gt 0 ]; do
  case "$1" in
    --board=*)
      b_arg="${1#*=}"
      ;;
    --raw=*)
      r_arg="${1#*=}"
      ;;
    --delay=*)
      d_arg="${1#*=}"
      ;;
    --loop=*)
      l_arg="${1#*=}"
      ;;
    --write=*)
      w_arg="${1#*=}"
      ;;
    --help)
      echo ""
      echo "DESCRIPTION:"
      echo "script for scraping useful informations from various boards."
      echo "creator: anon"
      echo ""
      echo "ARGUMENTS:"
      echo -e "${gray}--board${NC}  [str]    (specifies board from which the script will get informations)"
	  echo -e "${gray}--raw${NC}    [bool]   (specifies if output will be presented in pretty or raw form)"
      echo -e "${gray}--loop${NC}   [bool]   (specifies if script will execute only once or inifnite)"
      echo -e "${gray}--delay${NC}  [int]    (time between updates if the --loop is set to \"true\")"
      echo -e "${gray}--write${NC}  [string] (append output to file specified in argument if --raw is set to \"true\")"
      echo ""
      echo "DEFAULT:"     
      echo -e "${gray}--board${NC}=b" 
      echo -e "${gray}--raw${NC}=false"
      echo -e "${gray}--loop${NC}=false"
      echo -e "${gray}--delay${NC}=5"
      echo -e "${gray}--write${NC}=none (will not write)"
      echo ""
      echo "RAW FORMAT:"
      echo "[date (y-m-d h:m:s)],[board],[online],[active posts],[pontyfikat]"
      echo ""
      exit 0
      ;;
    *)
      echo -e "${red}***************************************${NC}"
      echo -e "${red}* Error: Invalid argument. use --help *${NC}"
      echo -e "${red}***************************************${NC}"
      exit 1
  esac
  shift
done

re='^[0-9]+$'
if ! [[ $d_arg =~ $re ]] ; then
   echo -e "${red}error: --delay must be an intiger"
   exit 1
fi

while :
do 
	online=$(. ${0%/*}/online.sh)
	posts=$(. ${0%/*}/posts.sh "$b_arg")
	pontyfikat=$(. ${0%/*}/pontyfikat.sh "$b_arg")

	if [ "$first_time" == "false" ]; then
		if [ "$r_arg" == "false" ]; then	
			echo -e '\033[4A'
		fi
	fi

    if [ "$r_arg" == "true" ];then 
        printf "$(date +'%Y-%m-%d %H:%M:%S'),$b_arg,$online,$posts,$pontyfikat\n"  	
    	if [ "$w_arg" != "none" ]; then
        	printf "$(date +'%Y-%m-%d %H:%M:%S'),$b_arg,$online,$posts,$pontyfikat\n" >> "$w_arg"	
    	fi
    else
        trap cleanup EXIT
        tput civis
		echo -e "ilość online: ${bold}$online${NC}"
		echo -e "ilość aktywnych postów dla boardu /$b_arg/ : ${bold}$posts${NC}"
		echo -e "ilość postów na pontyfikat dla boardu /$b_arg/ : ${bold}$pontyfikat${NC}"
    fi
    
	if [ "$l_arg" == "false" ]; then
		exit 0
	fi

    first_time="false"
	sleep "$d_arg"
done



