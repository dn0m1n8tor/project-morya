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

