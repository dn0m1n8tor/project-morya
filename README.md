<!-- # Project Morya -->
<!-- ![project-morya](https://user-images.githubusercontent.com/65735854/126045187-d12ae493-deba-4067-869d-e6a5b83090f7.png)
 -->
<!-- ![project-morya1](https://user-images.githubusercontent.com/65735854/126045210-a7384346-252a-42a4-b58e-7ba040e69e7e.png)
 -->
<!--  ![Banner](https://user-images.githubusercontent.com/65735854/135334459-a5bbe964-3f36-4fa8-9fcf-42c337662198.png) -->
 ![banner](https://user-images.githubusercontent.com/65735854/135578912-4588db29-fbd1-4774-ae3c-8e8f99c6f602.png)


 
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

<details>
<summary> 👉 Project Morya help menu 👈</summary>

```
Usage of ./project_MOrya:
 
  -s
        for only subdomain enumeration
  -m
        for medium level scan [subdomain Enumeration, subdomain Takeover, wayback_Urls, probing_Domains, nuclei_Scanning, port_Scanning]
  -a
        for advance level scan [subdomain Enumeration, subdomain Takeover, wayback_Urls, probing_Domains, nuclei_Scanning, port_Scanning, dirsearch, xss scan] 
```

</details>



# Running Project Morya

To run the tool on a target, just use the following command.

1. Subdomain Enumeration : ``./project_Morya.sh -s``
2. Medium Level Recon : ``./project_Morya.sh -m``
3. Advance Scope Recon : ``./project_Morya.sh -a``

</details>

[![Youtube Video](https://user-images.githubusercontent.com/65735854/135603583-d28451e9-eea4-4ecf-af51-d01155594f7b.png)]( https://www.youtube.com/watch?v=vC6BOx1oKes)

# ⚙️  Config files 

<details>
<summary> 👉 Configure your files 👈</summary>

### 1. Notify [ Most Important ] 

I have written an article to setup Notify : https://anubhav-singh.medium.com/notification-system-for-your-bug-bounty-automation-7b13af1b7372

### 2. Subfinder

[Link of the Article :point_down:](https://sidxparab.gitbook.io/subdomain-enumeration-guide/passive-enumeration/passive-sources)<br>
![image](https://user-images.githubusercontent.com/65735854/135441686-b93f9046-8e1e-4de2-a0a4-bce3985e6041.png)


### 3. Amass

[Link of the Article :point_down:](https://sidxparab.gitbook.io/subdomain-enumeration-guide/passive-enumeration/passive-sources)<br>
![image](https://user-images.githubusercontent.com/65735854/135441523-d422087d-a3c4-4b9d-b2f2-524487cbf825.png)

### 4. Github-subdomains

[Link of the Article :point_down:](https://sidxparab.gitbook.io/subdomain-enumeration-guide/passive-enumeration/passive-sources)<br>
![image](https://user-images.githubusercontent.com/65735854/135442501-9aea2b26-5fd1-48f3-a867-cbfbf6f14f1e.png)

Note : Keep atleast 5 tokens in `$HOME/.config/github-subdomains/tokens.txt`
![image](https://user-images.githubusercontent.com/65735854/135442906-59ba9f2c-4737-46e6-9dda-8d5f95da6131.png)
 
 ### 5. Shodan cli
 
`shodan init YOUR_API_KEY`

 ***If you have properly configured files then you are all set to use this framework***
 
</details>

# Tools Used

<details>
<summary> 👉 Tools used in project 👈</summary>

```
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
```
</details>

 # PR Notes
 
1. Please create a PR for the Feature Request.
2. If there is any missing part in install.sh please create a PR for it.
3. For specific tool related issue such as installation for X tool used by Project Morya is not successful, please do not create a PR for it. As this issue is required to be Raise to the specific Tool Owner.

**Please feel free to _contribute_**....
