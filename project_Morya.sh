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
source ./port_scanning.lib

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
                                                                                                      
                                                                                              - Coded by @AnubhavSingh_
"

while getopts ":smah" arg; do
  case "$arg" in
          subs )
            input_Domain
            subdomain_Enumeration
            printf "Work is completed" | notify --silent
            ;;
          m )
            input_Domain
            subdomain_Enumeration
            subdomain_Takeover
            wayback_Urls
            probing_Domains
            nuclei_Scanning
            port_Scanning
            printf "Work is completed" | notify --silent
            ;;
          a )
            input_Domain
            subdomain_Enumeration
            subdomain_Takeover
            wayback_Urls
            probing_Domains
            nuclei_Scanning
            port_Scanning
            dirsearch_Fuzzing
            xss_Hunter
            printf "Work is completed" | notify --silent
          ;;
          \? | h )
            help_me
          ;;
          * )
            echo "Invalid Argument";
          ;;
          esac
        done
