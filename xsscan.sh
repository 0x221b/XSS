#!/bin/bash

mkdir /root/Documents/BugBounty/xss/$1
python3 /opt/1.Recon/ParamSpider/paramspider.py --domain $1 --exclude svg,jpg,css,js | tee /root/Documents/BugBounty/xss/$1/params.txt
/root/go/bin/gf xss /root/Documents/BugBounty/xss/$1/params.txt | tee /root/Documents/BugBounty/xss/$1/xss.txt
grep -Eo '(http|https)://[^"]+' /root/Documents/BugBounty/xss/$1/xss.txt > /root/Documents/BugBounty/xss/$1/xssurl.txt
while read u
do
echo "\n\n"
echo $u ----------------
python3 /opt/2.Exploits/XSS/XSStrike/xsstrike.py -u $u
done < /root/Documents/BugBounty/xss/$1/xssurl.txt | tee /root/Documents/BugBounty/xss/$1/strike.txt
