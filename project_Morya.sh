#!/bin/bash
source ./wayback_urls.lib
source ./xss_hunter.lib
source ./subdomain_enumeration.lib
source ./nuclei.lib
source ./httpx.lib
source ./dirsearch.lib
source ./subdomain_takeover.lib

printf "
 ███████████                   ███                   █████       ██████   ██████                                       
░░███░░░░░███                 ░░░                   ░░███       ░░██████ ██████                                        
 ░███    ░███████████ ██████  █████ ██████  ██████  ███████      ░███░█████░███   ██████  ████████  █████ ████ ██████  
 ░██████████░░███░░█████░░███░░███ ███░░██████░░███░░░███░       ░███░░███ ░███  ███░░███░░███░░███░░███ ░███ ░░░░░███ 
 ░███░░░░░░  ░███ ░░░███ ░███ ░███░███████░███ ░░░   ░███        ░███ ░░░  ░███ ░███ ░███ ░███ ░░░  ░███ ░███  ███████ 
 ░███        ░███   ░███ ░███ ░███░███░░░ ░███  ███  ░███ ███    ░███      ░███ ░███ ░███ ░███      ░███ ░███ ███░░███ 
 █████       █████  ░░██████  ░███░░██████░░██████   ░░█████     █████     █████░░██████  █████     ░░███████░░████████
░░░░░       ░░░░░    ░░░░░░   ░███ ░░░░░░  ░░░░░░     ░░░░░     ░░░░░     ░░░░░  ░░░░░░  ░░░░░       ░░░░░███ ░░░░░░░░ 
                          ███ ░███                                                                   ███ ░███          
                         ░░██████                                                                   ░░██████           
                          ░░░░░░                                                                     ░░░░░░            	
"
printf "\n\n"
printf "\nPlease enter a domain : "
read DOMAIN

printf "\n==========================" | notify --silent
printf "\nProject is started" | notify --silent
sleep 2
printf "\n==========================" | notify --silent

printf "Domain provide to us: $DOMAIN\n" | notify --silent
TODAY=`date --date='+5 hour 30 minutes' '+%d/%b/%y %r'`
printf "Scanning is started at ${TODAY}" | notify --silent
printf "Creating directory ${DOMAIN}_recon\n" | notify --silent

Directory="${DOMAIN}_recon"
mkdir $Directory
cd $Directory
mkdir vulnerability
RUNNING_PATH=`pwd`

subdomain_enumeration
subdomain_takeover
wayback_urls
nuclei
dirsearch
xss_hunter

prinf "Work is completed Anubhav" | notify --silent
