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

printf "Collecting DNS_Resolvers\n" | notify --silent
dnsvalidator -tL https://public-dns.info/nameservers.txt -threads 500 -o resolvers.txt --silent

printf "Starting Subdomain Enumeration\n" | notify --silent

printf "Running Subfinder\n" | notify --silent
subfinder -d $DOMAIN -all --silent -config /home/ubuntu/automation/config_files/subfinder_config.yaml -o allsubs1.txt
wc -l allsubs1.txt | awk '{print $1 " subdomains founded by Subfinder"}' | notify --silent

printf "Running CRT.sh\n" | notify --silent
python3 /home/ubuntu/tools/ctfr/ctfr.py -d $DOMAIN -o allsubs2.txt
wc -l allsubs2.txt | awk '{print $1 " subdomains founded by CRT.sh"}' | notify --silent

printf "Running AssetFinder\n" | notify --silent
assetfinder $DOMAIN >>allsubs3.txt
wc -l allsubs3.txt | awk '{print $1 " subdomains founded by AssetFinder"}' | notify --silent

printf "Running Finddomain\n" | notify --silent
findomain -t $DOMAIN -u allsubs4.txt
wc -l allsubs4.txt | awk '{print $1 " subdomains founded by Finddomain"}' | notify --silent

printf "Running sd-goo.sh (Domains from google search)\n" | notify --silent
sd-goo.sh $DOMAIN | sort -u >>allsubs5.txt
wc -l allsubs5.txt | awk '{print $1 " subdomains founded by sd-goo.sh"}' | notify --silent

# printf "---------Running Shodan to find---------\n" | notify --silent

# shodan_dorks=(ssl.cert.subject.cn:$DOMAIN hostname:$DOMAIN org:$DOMAIN)
# for i in "${shodan_dorks[@]}"; do
# 	shodan search "$i" --fields ip_str,port --separator " " | awk '{print $1":"$2}' >>shodan_${DOMAIN}_ips.txt
# 	cat shodan_${DOMAIN}_ips.txt | awk -F ':' '{print $1}' | dnsx -ptr -resp-only >>allsubs6.txt
# done

printf "Running Amass" | notify --silent
amass enum -passive -d $DOMAIN -config /home/ubuntu/automation/config_files/config.ini -o allsubs7.txt -timeout 30
wc -l allsubs7.txt | awk '{print $1 " subdomains founded by Amass"}'  | notify --silent

printf "Running gauplus\n" | notify --silent
gauplus -t 5 -random-agent -subs $DOMAIN | unfurl -u domains | sort -u >>allsubs8.txt
wc -l allsubs8.txt | awk '{print $1 " subdomains founded by gauplus"}'  | notify --silent

printf "Running Waybackurls\n" | notify --silent
waybackurls $DOMAIN | unfurl -u domains | sort -u >>allsubs9.txt
wc -l allsubs9.txt | awk '{print $1 " subdomains founded by Waybackurls"}'  | notify --silent

printf "Running Github-subdomains\n" | notify --silent
github-subdomains -d $DOMAIN -t /home/ubuntu/automation/config_files/tokens.txt -o allsubs10.txt
wc -l allsubs10.txt | awk '{print $1 " subdomains founded by Github-subdomains"}'  | notify --silent

printf "Running crobat\n" | notify --silent
crobat -s $DOMAIN >>allsubs11.txt
wc -l allsubs11.txt | awk '{print $1 " subdomains founded by crobat"}' | notify --silent

printf "Running tls.bufferover\n" | notify --silent
curl "https://tls.bufferover.run/dns?q=$DOMAIN" | jq -r .Results'[]' | cut -d ',' -f3 | grep -F "$DOMAIN" | sort -u >>allsubs12.txt
wc -l allsubs12.txt | awk '{print $1 " subdomains founded by tls.bufferover"}' | notify --silent

printf "Running dns.bufferover\n" | notify --silent
curl "https://dns.bufferover.run/dns?q=$DOMAIN" | jq -r .FDNS_A'[]',.RDNS'[]' | cut -d ',' -f2 | grep -F "$DOMAIN" | sort -u >>allsubs13.txt
wc -l allsubs13.txt | awk '{print $1 " subdomains founded by dns.bufferover"}' | notify --silent

printf "Running Puredns\n" | notify --silent
dnsvalidator -tL https://public-dns.info/nameservers.txt -threads 500 -o resolvers.txt --silent
puredns bruteforce ../../config_files/best-dns-wordlist.txt $DOMAIN -r resolvers.txt -w allsubs14.txt --wildcard-batch 1000000
wc -l allsubs14.txt | awk '{print $1 " subdomains founded by Puredns"}' | notify --silent

printf "Sorting Colleted Subdomains\n" | notify --silent
sort allsubs*.txt | uniq -u >>subdomains.txt
wc -l subdomains.txt | awk '{print $1 " subdomains are founded"}' | notify --silent

printf "Running DNSCewl\n" | notify --silent
DNScewl --tL subdomains.txt -p /home/ubuntu/automation/config_files/permutations_list.txt --level=0 --subs --no-color | tail -n +14 >permutations.txt
printf "Running Puredns for resolving permutatuon subdomains\n"  | notify --silent
dnsvalidator -tL https://public-dns.info/nameservers.txt -threads 500 -o resolvers.txt --silent
puredns resolve permutations.txt -r resolvers.txt --wildcard-batch 1000000 -w allsubs15.txt
wc -l allsubs15.txt | awk '{print $1 " subdomains founded by DNScewl and Puredns"}' | notify --silent
rm permutations.txt
sort subdomains.txt allsub15.txt | uniq -u >>subdomains.txt

printf "Scraping Subdomains from JS/Source code\n" | notify --silent
cat subdomains.txt | httpx -random-agent -retries 2 -no-color -o probed_tmp_scrap.txt
gospider -S probed_tmp_scrap.txt --js -t 50 -d 3 --sitemap --robots -w -r >gospider.txt
sed -i '/^.\{2048\}./d' gospider.txt
cat gospider.txt | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | unfurl -u domains | grep ".$DOMAIN" | sort -u >>allsub16.txt
rm gospider.txt
sort subdomains.txt allsub16.txt | uniq -u >>subdomains.txt
wc -l subdomains.txt | awk '{print $1 " are total subdomains founded by Project Morya"}'  | notify --silent

# echo "Probing on common ports \n" | notify --silent
# COMMON_PORTS_WEB="81,300,591,593,832,981,1010,1311,1099,2082,2095,2096,2480,3000,3128,3333,4243,4567,4711,4712,4993,5000,5104,5108,5280,5281,5601,5800,6543,7000,7001,7396,7474,8000,8001,8008,8014,8042,8060,8069,8080,8081,8083,8088,8090,8091,8095,8118,8123,8172,8181,8222,8243,8280,8281,8333,8337,8443,8500,8834,8880,8888,8983,9000,9001,9043,9060,9080,9090,9091,9200,9443,9502,9800,9981,10000,10250,11371,12443,15672,16080,17778,18091,18092,20720,32000,55440,55672"
# unimap --fast-scan -f subdomains.txt --ports $COMMON_PORTS_WEB -q -k --url-output >unimap_commonweb.txt
# cat unimap_commonweb.txt | httpx -random-agent -status-code -silent -retries 2 -no-color | cut -d ' ' -f1 >>probed_common_ports.txt
# rm unimap_commonweb.txt

printf "\nSubdomain Enumeration Completed" | notify --silent
