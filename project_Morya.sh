#!/bin/bash
source ./input_domain.lib
source ./wayback_urls.lib
source ./xss_hunter.lib
source ./subdomain_enumeration.lib
source ./nuclei.lib
source ./probing.lib
source ./dirsearch.lib
source ./subdomain_takeover.lib
source ./help_me.lib

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
                                                                                                      
                                                                                                      - @AnubhavSingh_
"

while getopts ":smah" arg; do
  case "$arg" in
  s)
   input_Domain
   subdomain_Enumeration
   ;;
  m)
   input_Domain
   subdomain_Enumeration
   subdomain_Takeover
   wayback_Urls
   probing_Domains
   nuclei_Scanning
  ;;
  a)
   input_Domain
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
