#!/bin/bash

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

printf "Domain provide to us: $DOMAIN\n"
printf "Creating directory ${DOMAIN}_recon\n"

Directory="${DOMAIN}_recon"
mkdir $Directory
cd $Directory
mkdir Subdomains
cd Subdomains

printf "Collecting DNS_Resolvers\n" | notify
dnsvalidator -tL https://public-dns.info/nameservers.txt -threads 500 -o resolvers.txt --silent

printf "Starting Subdomain Enumeration\n" | notify

printf "Running Subfinder\n" | notify
subfinder -d $DOMAIN -all --silent -config ../../config_files/subfinder_config.yaml -o allsubs1.txt

printf "Running CRT.sh\n" | notify
curl "https://crt.sh/?q=$DOMAIN&output=json" | jq -r ".[] | .name_value" >>allsubs2.txt

printf "Running AssetFinder\n" | notify
assetfinder $DOMAIN >>allsubs3.txt

printf "Running Finddomain\n" | notify
findomain -t $DOMAIN -u allsubs4.txt

printf "Running sd-goo.sh (Domains from google search)\n" | notify
sd-goo.sh $DOMAIN | sort -u >>allsubs5.txt

# printf "---------Running Shodan to find---------\n" | notify

# shodan_dorks=(ssl.cert.subject.cn:$DOMAIN hostname:$DOMAIN org:$DOMAIN)
# for i in "${shodan_dorks[@]}"; do
# 	shodan search "$i" --fields ip_str,port --separator " " | awk '{print $1":"$2}' >>shodan_${DOMAIN}_ips.txt
# 	cat shodan_${DOMAIN}_ips.txt | awk -F ':' '{print $1}' | dnsx -ptr -resp-only >>allsubs6.txt
# done

printf "Running Amassn" | notify
amass enum -passive -d $DOMAIN -config ../../config_files/config.ini -o allsubs7.txt

printf "Running gauplus\n" | notify
gauplus -t 5 -random-agent -subs $DOMAIN | unfurl -u domains | sort -u >>allsubs8.txt

printf "Running Waybackurls\n" | notify
waybackurls $DOMAIN | unfurl -u domains | sort -u >>allsubs9.txt

printf "Running Github-subdomains\n" | notify
github-subdomains -d $DOMAIN -t ../../config_files/tokens.txt -o allsubs10.txt

printf "Running crobat\n" | notify
crobat -s $DOMAIN >>allsubs11.txt

printf "Running tls.bufferover\n" | notify
curl "https://tls.bufferover.run/dns?q=$DOMAIN" | jq -r .Results'[]' | cut -d ',' -f3 | grep -F "$DOMAIN" | sort -u >>allsubs12.txt

printf "Running dns.bufferover\n" | notify
curl "https://dns.bufferover.run/dns?q=$DOMAIN" | jq -r .FDNS_A'[]',.RDNS'[]' | cut -d ',' -f2 | grep -F "$DOMAIN" | sort -u >>allsubs13.txt

printf "Running Puredns\n" | notify
puredns bruteforce ../../config_files/best-dns-wordlist.txt $DOMAIN -r resolvers.txt -w allsubs14.txt --wildcard-batch 1000000

printf "Sorting Colleted Subdomains\n" | notify
sort allsubs*.txt | uniq -u >>subdomains.txt

printf "Running DNSCewl\n" | notify
DNScewl --tL subdomains.txt -p ../../config_files/permutations_list.txt --level=0 --subs --no-color | tail -n +14 >permutations.txt
printf "Running Puredns for resolving permutatuon subdomains\n"
puredns resolve permutations.txt -r resolvers.txt --wildcard-batch 1000000 -w allsubs15.txt
rm permutations.txt

printf "Scraping Subdomains from JS/Source code\n" | notify
cat subdomains.txt | httpx -random-agent -retries 2 -no-color -o probed_tmp_scrap.txt
gospider -S probed_tmp_scrap.txt --js -t 50 -d 3 --sitemap --robots -w -r >gospider.txt
sed -i '/^.\{2048\}./d' gospider.txt
cat gospider.txt | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | unfurl -u domains | grep ".$DOMAIN" | sort -u >>allsub16.txt
rm gospider.txt
sort subdomains.txt allsub16.txt | uniq -u >>subdomains.txt

# echo "Probing on common ports \n" | notify
# COMMON_PORTS_WEB="81,300,591,593,832,981,1010,1311,1099,2082,2095,2096,2480,3000,3128,3333,4243,4567,4711,4712,4993,5000,5104,5108,5280,5281,5601,5800,6543,7000,7001,7396,7474,8000,8001,8008,8014,8042,8060,8069,8080,8081,8083,8088,8090,8091,8095,8118,8123,8172,8181,8222,8243,8280,8281,8333,8337,8443,8500,8834,8880,8888,8983,9000,9001,9043,9060,9080,9090,9091,9200,9443,9502,9800,9981,10000,10250,11371,12443,15672,16080,17778,18091,18092,20720,32000,55440,55672"
# unimap --fast-scan -f subdomains.txt --ports $COMMON_PORTS_WEB -q -k --url-output >unimap_commonweb.txt
# cat unimap_commonweb.txt | httpx -random-agent -status-code -silent -retries 2 -no-color | cut -d ' ' -f1 >>probed_common_ports.txt
# rm unimap_commonweb.txt

printf "\nSubdomain Enumeration Completed" | notify
