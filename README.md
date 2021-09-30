<!-- # Project Morya -->
<!-- ![project-morya](https://user-images.githubusercontent.com/65735854/126045187-d12ae493-deba-4067-869d-e6a5b83090f7.png)
 -->
<!-- ![project-morya1](https://user-images.githubusercontent.com/65735854/126045210-a7384346-252a-42a4-b58e-7ba040e69e7e.png)
 -->
 ![Banner](https://user-images.githubusercontent.com/65735854/135334459-a5bbe964-3f36-4fa8-9fcf-42c337662198.png)

 
Project Morya is just a collection of bash scripts that runs iteratively to carry out various tools and recon process & store output in an organized way. This Project was built to automate my recon process, and after working on this project for months, I thought to make Project Morya public.

Please feel free to improve it in any way you can. There is no secret involved, and it's just a set of commands and existing tools written in bash-scripts for simple Recon Automation.

Currently this tools supports performing recon for:
 
 1.  Subdomain Enumeration: <br>
      It just enumerate subdomain 
      
 2.  Medium Level Scan: <br>
      It scan's for [ subdomain Enumeration, subdomain Takeover, wayback_Urls, probing_Domains, nuclei_Scanning, port_Scanning ]
      
 3.  Advance level Scan: <br>
      It scan's for [ subdomain Enumeration, subdomain Takeover, wayback_Urls, probing_Domains, nuclei_Scanning, port_Scanning, dirsearch, xss scan ] 

# Installation Instructions

```
Note : Run this commands as a root user

$ git clone <repo>
$ cd project-morya
$ chmod +x install.sh project_Morya.sh
$ ./install.sh
```
# Usage

```sh
./project_Morya -h
```
This will display help for the tool. Here are all the switches it supports.

To run the tool on a target, just use the following command.

<details>
<summary> 👉 Project Morya help menu 👈</summary>

```
Usage of ./project_MOrya:
 
  -subs
        for only subdomain enumeration
  -m
        for medium level scan [subdomain Enumeration, subdomain Takeover, wayback_Urls, probing_Domains, nuclei_Scanning, port_Scanning]
  -a
        for advance level scan [subdomain Enumeration, subdomain Takeover, wayback_Urls, probing_Domains, nuclei_Scanning, port_Scanning, dirsearch, xss scan] 
```

</details>

# Running Project Morya

1. Subdomain Enumeration : ``./project_Morya.sh -subs``
2. Medium Level Recon : ``./project_Morya.sh -m``
3. Advance Scope Recon : ``./project_Morya.sh -a``


# Tools Used

 1. subfinder
 2. ctfr.py
 3. Assestfinder
 4. Findomain
 5. sd-goo
 5. shodan
 6. anew
 7. amass
 8. gauplus
 9. waybackurls
10. github-subdomains
11. Crobat
12. Puredns
13. DNSCewl
14. dnsvalidator
15. httpx
16. Gospider
17. Notify
18. Unfurl
19. Unimap
20. Subjack
21. Dirsearch
22. Parmaspider
23. kxss
24. Dnsx
25. jq
26. Naabu
27. Nmap
28. Dalfox
29. Nuclei
 
 # PR Notes
 
1. If there is any GO Version/Path related issues, please do not create a PR for it.
2. Please create a PR for the Feature Request.
3. If there is any missing part in install.sh please create a PR for it.
4. For specific tool related issue such as installation for X tool used by Project Morya is not successful, please do not create a PR for it. As this issue is required to be Raise to the specific Tool Owner.

### Please feel free to contribute.
