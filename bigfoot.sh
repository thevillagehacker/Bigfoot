#!/bin/bash

# version
version=1.0

# banner
echo -e """\e[0;32m                                 
 ______  __          ___                __   
|   __ \|__|.-----..'  _|.-----..-----.|  |_ 
|   __ <|  ||  _  ||   _||  _  ||  _  ||   _|
|______/|__||___  ||__|  |_____||_____||____|
            |_____|

          ------------------          
       ~ |Do Hacks to Secure| ~
          ------------------
    https://twitter.com/thevillagehackr
    https://github.com/thevillagehacker
    
      Hey don't miss this version $version
\033[0;37m"""

#check dependency
if ! [ -x "$(command -v http)" ]; then
  echo -e '\e[0;31m[-] Error: http is not installed\033[0;37m' >&2
  echo '[+] Run following command to install http'
  echo 'sudo apt get install httpie'
  exit 1
fi

#heroku service error page check
domcheck()
{
	http -b GET http://$tar 2> /dev/null | grep -F -q "//www.herokucdn.com/error-pages/no-such-app.html" && echo -e "\e[0;32m[+] Subdomain takeover may be possible\033[0;37m" || echo -e "\e[0;31m[-] Subdomain takeover is not possible\033[0;37m"

}

bulkcheck()
{
	for i in `cat $tar`; do echo $i; http -b GET http://$i 2> /dev/null | grep -F -q "//www.herokucdn.com/error-pages/no-such-app.html" && echo -e "\e[0;32m[+] Subdomain takeover may be possible\033[0;37m" || echo -e "\e[0;31m[-] Subdomain takeover is not possible\033[0;37m"; done
}

#input check
if [ "$1" = "-d" ]; then
  tar=$2
  domcheck
elif [ "$1" = "-f" ]; then
	tar=$2
    bulkcheck	
else
	echo -e "\e[5m\e[41m\033[1;97m No Inputs supplied \033[0;37m"
	echo -e "usage: ./heroku-sub.sh -d <example.com>"
	echo -e "       ./heroku-sub.sh -f <targets.txt>"
fi
