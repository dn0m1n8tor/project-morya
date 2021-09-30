#!/bin/bash

#============================================================================================
echo "Installing required tools ....."
echo ""
echo ""
mkdir $HOME/tools/
mkdir $HOME/wordlist/

#============================================================================================
echo "Updating the list of packages on your system"

sudo apt update

echo "Updated successfully"

#============================================================================================
echo "Installing python3"

sudo apt-get install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.8

echo "Installing Go language"

#Download the Go binary
wget https://golang.org/dl/go1.16.8.linux-amd64.tar.gz

#Remove previous golang installation and extract the new one
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.8.linux-amd64.tar.gz

#Copy the binary to be able to use for any user
cp /usr/local/go/bin/go /usr/bin

#Add these line to your terminal config file(.bashrc/.zshrc)
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH
rm go1.16.8.linux-amd64.tar.gz

#Source your terminal (or restart terminal)
source ~/.bashrc 

echo "Go language installed"

#==============================================================================================
echo "Installing pip3"

sudo apt-get install python3-pip

echo "pip3 installed"

#==============================================================================================
echo "Installing subfinder"

GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder

echo "Subfinder Installed"

#==============================================================================================
echo "Installing ctfr.py"

cd $HOME/tools/ && git clone https://github.com/UnaPibaGeek/ctfr.git
cd ctfr
pip3 install -r requirements.txt

echo "ctfr.py installed"

#==============================================================================================
echo "Installing Assestfinder"

go get -u github.com/tomnomnom/assetfinder

echo "Assetfinder installed"

#==============================================================================================
echo "Installing Findomain"

cd $HOME/tools/ && wget https://github.com/findomain/findomain/releases/latest/download/findomain-linux
chmod +x findomain-linux
mv findomain-linux /usr/local/bin/findomain

echo "Findomain installed"

#==============================================================================================
echo "Installing sd-goo"

cd $HOME/tools/ && git clone https://github.com/darklotuskdb/sd-goo.git && cd sd-goo && chmod +x *.sh
mv sd-goo.sh /usr/local/bin

echo "sd-goo installed"

#==============================================================================================
echo "Installing shodan"

pip install -U --user shodan

#==============================================================================================
echo "Installing anew"

go get -u github.com/tomnomnom/anew

echo "anew installed"

#==============================================================================================
echo "Installing amass"

snap refresh
sudo snap install amass

echo "amass installed"

#==============================================================================================
echo "Installing gauplus"

GO111MODULE=on go get -u -v github.com/bp0lr/gauplus

echo "Gauplus installed"
#==============================================================================================
echo "Installing waybackurls"

go get github.com/tomnomnom/waybackurls

echo "Waybackurls installed"

#==============================================================================================
echo "Installing github-subdomains"

go get -u github.com/gwen001/github-subdomains

echo "github-subdomains installed"

#==============================================================================================
echo "Installing Crobat"

go get github.com/cgboal/sonarsearch/crobat

echo "Crobat installed"
#==============================================================================================
echo "Installing Puredns"

cd $HOME/tools/ && git clone https://github.com/blechschmidt/massdns.git
cd massdns && make && make install

GO111MODULE=on go get github.com/d3mondev/puredns/v2

echo "Puredns installed"

#==============================================================================================
echo "Installing DNSCewl"

cd $HOME/tools/ && wget https://github.com/codingo/DNSCewl/raw/master/DNScewl
chmod 755 DNScewl
mv DNScewl /usr/local/bin/DNScewl

echo "DNSCewl installed"

#==============================================================================================
echo "Installing dnsvalidator"

cd $HOME/tools/ && git clone https://github.com/vortexau/dnsvalidator.git
cd dnsvalidator/
python3 setup.py install

echo "DNSCewl installed"

#==============================================================================================
echo "Installing httpx"

GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx

echo "httpx installed"

#==============================================================================================
echo "Installing Gospider"

GO111MODULE=on go get -u github.com/jaeles-project/gospider

echo "Gospider installed"

#==============================================================================================
echo "Installing Notify"

GO111MODULE=on go get -v github.com/projectdiscovery/notify/cmd/notify

echo "Notify installed"
#==============================================================================================
echo "Installing Unfurl"

go get -u github.com/tomnomnom/unfurl

echo "Unfurl installed"

#==============================================================================================
echo "Installing Unimap"

cd $HOME/tools/ && eval wget -N -c https://github.com/Edu4rdSHL/unimap/releases/download/0.4.0/unimap-linux
chmod 755 unimap-linux
mv unimap-linux /usr/local/bin/unimap

echo "Unimap installed"

#==============================================================================================
echo "Installing Subjack"

go get github.com/haccer/subjack

echo "Subjack installed"

#==============================================================================================
echo "Installing Dirsearch"

cd $HOME/tools/ && git clone https://github.com/maurosoria/dirsearch.git
cd dirsearch
pip3 install -r requirements.txt

echo "Dirsearch installed"

#==============================================================================================
echo "Installing Parmaspider"

cd $HOME/tools/ && git clone https://github.com/devanshbatham/ParamSpider
cd ParamSpider
pip3 install -r requirements.txt

echo "Paramspider installed"

#==============================================================================================
echo "Installing kxss"

cd $HOME/tools/ && git clone https://github.com/tomnomnom/hacks.git
cd hacks/kxss/ && go build 
cp kxss /usr/local/bin

echo "Kxss installed"

#==============================================================================================
echo "Installing Dnsx"

go get -v github.com/projectdiscovery/dnsx/cmd/dnsx

echo "Dnsx installed"

#==============================================================================================
echo "Installing jq"

apt install jq

echo "JQ installed"

#==============================================================================================
echo "Installing Naabu"

sudo apt install -y libpcap-dev
GO111MODULE=on go get -v github.com/projectdiscovery/naabu/v2/cmd/naabu

echo "Naabu Installed"
#==============================================================================================
echo "Installing Nmap"

sudo apt-get install nmap

echo "Nmap installed"

#==============================================================================================
echo "Installing Dalfox"

GO111MODULE=on go get github.com/hahwul/dalfox/v2

echo "Dalfox installed"

#==============================================================================================
echo "Downloading best-dns-wordlist.txt and permutation words"

wget https://wordlists-cdn.assetnote.io/data/manual/best-dns-wordlist.txt -P $HOME/wordlist/
wget https://gist.githubusercontent.com/six2dez/ffc2b14d283e8f8eff6ac83e20a3c4b4/raw -P $HOME/wordlist/ && mv $HOME/wordlist/raw $HOME/wordlist/permutations_list.txt

#==============================================================================================
printf "\n Tools are successfully Installed"
