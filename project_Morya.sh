#!/bin/bash
source ./wayback_urls.lib
source ./xss_hunter.lib
source ./subdomain_enumeration.lib
source ./nuclei.lib
source ./probing.lib
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
printf "\nProject Morya started" | notify --silent
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

while getopts ":smah" arg; do
  case "$arg" in
  s)
   subdomain_Enumeration
   ;;
  m)
   subdomain_Enumeration
   subdomain_Takeover
   wayback_Urls
   probing_Domains
   nuclei_Scanning
  ;;
  a)
   subdomain_Enumeration
   subdomain_Takeover
   wayback_Urls
   probing_Domains
   nuclei_Scanning
   dirsearch_Fuzzing
   xss_Hunter
  ;;
  h)
  help_me
  ;;
  *)
  printf "Please provide right argument for scan"
  ;;
  esac
done

printf "Work is completed Anubhav" | notify --silent
