#!/bin/bash

##-----------------------------------------------------------------------------------------------------------------------------
##-------------------------------------------------For so Single Domains------------------------------------------------------
##-----------------------------------------------------------------------------------------------------------------------------


echo "+++++++++++++++++++++++++++++++Welcome TO Scanner++++++++++++++++++++++++++++"

nuclei --update-templates --silent

read -p "\nEnter domain name seprated by space : " input
for i in ${input[@]}
do

echo "."
echo "."
echo "."
echo "."


echo "Scan startted for $i"

mkdir $i

subfinder -d $i | httpx >> $i/$i-subdomain.txt

echo "subdomain saved at $i/$i-subdomain.txt"

echo "Scan for CVES started"
nuclei -l $i/$i-subdomain.txt -silent -t cves/ -o $i/cves.txt
echo "Scan for cves competed"
echo "Scan for defualt login started"
nuclei -l $i/$i-subdomain.txt -silent -t defualt-logins/ -o $i/defualt-logins.txt
echo "Scan for defualt login completed"
echo "Scan for Exposures started"
nuclei -l $i/$i-subdomain.txt -silent -t exposures/ -o $i/exposures.txt
echo "Scan for Exposures completed"
echo "Scan for Misconfiguration started"
nuclei -l $i/$i-subdomain.txt -silent -t misconfiguration/ -o $i/misconfiguration.txt
echo "scan for misconfiguration completed"
echo "Scan for Takeover started"
nuclei -l $i/$i-subdomain.txt -silent -t takeovers/ -o $i/takeover.txt
echo "Scan for Takeover completed"
echo "Scan for vulnerablity started"
nuclei -l $i/$i-subdomain.txt -silent -t vulnerabilies/ -o $i/vulnerabilies.txt 
echo "Scan for vulnerablity completed"


echo "
.
.
Scan finished for $i
.
.
"
done


##-----------------------------------------------------------------------------------------------------------------------------
##-------------------------------------------------For so many subdomains------------------------------------------------------
##-----------------------------------------------------------------------------------------------------------------------------

printf "_________________________________\n"
printf "subdomain are going for scanning\n"

mkdir nuclei_output

printf "Scan for CVES started\n"
nuclei -l subdomains.txt -silent -t ~/nuclei-templates/cves/ -o nuclei_output/cves.txt
printf "Scan for cves competed\n"

printf "Scan for defualt login started\n"
nuclei -l subdomains.txt -silent -t ~/nuclei-templates/defualt-logins/ -o nuclei_output/defualt-logins.txt
printf "Scan for defualt login completed\n"

printf "Scan for Exposures started\n"
nuclei -l subdomains.txt -silent -t ~/nuclei-templates/exposures/ -o nuclei_output/exposures.txt
printf "Scan for Exposures completed\n"

printf "Scan for Misconfiguration started\n"
nuclei -l subdomains.txt -silent -t ~/nuclei-templates/misconfiguration/ -o nuclei_output/misconfiguration.txt
printf "scan for misconfiguration completed\n"

printf "Scan for Takeover started\n"
nuclei -l subdomains.txt -silent -t ~/nuclei-templates/takeovers/ -o nuclei_output/takeover.txt
printf "Scan for Takeover completed\n"

printf "Scan for vulnerablity started\n"
nuclei -l subdomains.txt -silent -t ~/nuclei-templates/vulnerabilies/ -o nuclei_output/vulnerabilies.txt 
printf "Scan for vulnerablity completed\n"

prinf "\nScan is completed"
