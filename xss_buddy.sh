#!/bin/bash

figlet "XSS Scan"

nuclei --update-templates --silent

read -p "Enter domain to scan XSS : " DOMAIN 

printf "."
printf "."
printf "."
printf "."
printf "Scan started for $DOMAIN\n" | notify -silent

mkdir $DOMAIN_recon
cd $DOMAIN_recon
printf "[+] Probing Subdomains \n"
cat subdomains.txt | httpx -random-agent
figlet "Waybackurls"
printf "[-] waybackurls started crawling\n" | notify --silent
cat subdomains.txt | waybackurls > $DOMAIN_wayback.txt
printf "[+] waybackurls completed crawling\n" | notify --silent 

figlet "Gau"
printf "[-] gau started crawling\n" | notify -silent
cat subdomains.txt | gau > $DOMAIN_gau.txt
printf "[+] gau completed crawling\n" | notify -silent

printf "[-] paramspider started crawling\n" | notify -silent
python3 /home/ubuntu/tools/ParamSpider/paramspider.py -d $DOMAIN -silent -o $DOMAIN-param.txt
printf "[+] paramspider completed crawling\n" | notify -silent

cat $DOMAIN_wayback.txt $DOMAIN_gau.txt | sort -u >> $DOMAIN_final_urls.txt

figlet "JS-SCAN"
printf "[-] JS-scan started \n" | notify -silent
cat $DOMAIN_final_urls.txt | grep "\.js" | sed 's/?.*//' | sort -u >> $DOMAIN_JS_files.txt
for j in $(cat $DOMAIN_JS_files.txt)
do
python3 /home/ubuntu/tools/LinkFinder/linkfinder.py -i $j -o cli >> $DOMAIN_js_secrets.txt
done

figlet "GF pattern"
printf "[-] GF pattern started \n" | notify -silent
mkdir GF
cat $DOMAIN_final_urls.txt | gf xss >> GF/final-xss.txt
cat $DOMAIN_final_urls.txt | gf ssrf >> GF/final-ssrf.txt
cat $DOMAIN_final_urls.txt | gf idor >> GF/final-idor.txt
printf "[+] GF pattern completed \n" | notify -silent

figlet "ROHIT pattern"
printf "[-] ROHIT pattern started \n" | notify -silent
mkdir rohit
cat $DOMAIN_final_urls.txt | grep "=" | egrep -iv ".(jpg|jpeg|css|gif|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt|js)" >> rohit/final-rohit.txt

cat $DOMAIN-param.txt | grep "=" | egrep -iv ".(jpg|jpeg|css|gif|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt|js)" >> rohit/param-rohit.txt
printf "[+] ROHIT pattern completed \n" | notify -silent

figlet "KXSS"
printf "[-] kxss scan started\n" | notify -silent
mkdir kxss
cat $DOMAIN_final_urls.txt | kxss >> kxss/final-kxss.txt
cat rohit/param-rohit.txt | kxss >> kxss/param-kxss.txt
printf "[+] kxss scan completed\n" | notify -silent


figlet "Nuclei"
printf "[-] Nuclei scan for XSS started\n" | notify -silent
mkdir final
nuclei -tags xss -l rohit/final-rohit.txt -t ~/nuclei-templates/vulnerabilities/ -t ~/nuclei-templates/vulnerabilities/cves/ -silent -o final/xss-nuclei.txt
printf "[+] Nuclei scan for XSS completed\n" | notify -silent

figlet "Dalfox"
printf "[-] Dalfox Scan started\n" | notify -silent
cat rohit/final-rohit.txt | dalfox pipe -S -b https://anubhav1403.xss.ht -o final/xss-dalfox.txt
printf "[+] Dalfox Scan completed\n" | notify -silent

printf "\nXSS Scan completed_____________"
