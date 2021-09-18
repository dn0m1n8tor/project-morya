#!/bin/bash

#============================================================================================
#Download the Go binary
wget https://golang.org/dl/go1.15.10.linux-amd64.tar.gz

#Remove previous golang installation and extract the new one
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.15.10.linux-amd64.tar.gz

#Copy the binary to be able to use for any user
cp /usr/local/go/bin/go /usr/bin

#Add these line to your terminal config file(.bashrc/.zshrc)
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH

#Source your terminal (or restart terminal)
source ~/.bashrc 

#==============================================================================================
#Installing pip3

sudo apt-get install python3-pip

#==============================================================================================
#Installing subfinder

GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder

#==============================================================================================
#Installing ctfr.py

cd $HOME/tools/ && git clone https://github.com/UnaPibaGeek/ctfr.git
cd ctfr
pip3 install -r requirements.txt

#==============================================================================================
#Installing Assestfinder

go get -u github.com/tomnomnom/assetfinder

#==============================================================================================
#Installing Findomain

cd $HOME/tools/ && wget https://github.com/findomain/findomain/releases/latest/download/findomain-linux
chmod +x findomain-linux
mv findomain-linux /usr/local/bin/findomain

#==============================================================================================
#Installing sd-goo

cd $HOME/tools/ && git clone https://github.com/darklotuskdb/sd-goo.git && cd sd-goo && chmod +x *.sh 

#==============================================================================================
#Installing shodan

pip install -U --user shodan

#==============================================================================================
#Installing anew

go get -u github.com/tomnomnom/anew

#==============================================================================================
#Installing amass

snap refresh
sudo snap install amass

#==============================================================================================
#Installing gauplus

GO111MODULE=on go get -u -v github.com/bp0lr/gauplus

#==============================================================================================
#Installing waybackurls

go get github.com/tomnomnom/waybackurls

#==============================================================================================
#Installing github-subdomains

go get -u github.com/gwen001/github-subdomains

#==============================================================================================
#Installing Crobat

go get github.com/cgboal/sonarsearch/crobat

#==============================================================================================
#Installing Puredns

cd $HOME/tools/ && git clone https://github.com/blechschmidt/massdns.git
cd massdns && make && make install

GO111MODULE=on go get github.com/d3mondev/puredns/v2

#==============================================================================================
#Installing DNSCewl

cd $HOME/tools/ && wget https://github.com/codingo/DNSCewl/raw/master/DNScewl
chmod 755 DNScewl
mv DNScewl /usr/local/bin/DNScewl

#==============================================================================================
#Installing dnsvalidator

cd $HOME/tools/ && git clone https://github.com/vortexau/dnsvalidator.git
cd dnsvalidator/
python3 setup.py install

#==============================================================================================
#Installing httpx

GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx

#==============================================================================================
#Installing Gospider

GO111MODULE=on go get -u github.com/jaeles-project/gospider

#==============================================================================================
#Installing Notify

GO111MODULE=on go get -v github.com/projectdiscovery/notify/cmd/notify

#==============================================================================================
#Installing Unfurl

go get -u github.com/tomnomnom/unfurl

#==============================================================================================
#Installing Unimap

cd $HOME/tools/ && eval wget -N -c https://github.com/Edu4rdSHL/unimap/releases/download/0.4.0/unimap-linux
mv unimap-linux /usr/local/bin/unimap

#==============================================================================================
#Installing Subjack

go get github.com/haccer/subjack

#==============================================================================================
#Installing Dirsearch

cd $HOME/tools/ && git clone https://github.com/maurosoria/dirsearch.git
cd dirsearch
pip3 install -r requirements.txt

#==============================================================================================
#Installing Parmspider

cd $HOME/tools/ && git clone https://github.com/devanshbatham/ParamSpider
cd ParamSpider
pip3 install -r requirements.txt

#==============================================================================================
#Installing Parmspider

cd $HOME/tools/ && https://github.com/tomnomnom/hacks.git
cd hacks/kxss/ && go build 
cp kxss /usr/local/bin

#==============================================================================================
printf "\n Tools are successfully Installed"
