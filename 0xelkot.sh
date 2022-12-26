#!/bin/bash 

domain=$1
mkdir $1
mkdir $1/xray

./subfinder -d $1 -silent | ./anew $1/subs.txt
./assetfinder -subs-only $1 | ./anew $1/subs.txt
./amass enum -passive -d $1 | ./anew $1/subs.txt
                                                                                                                                                                                                             
                                                                                                                                                                                                             
                                                                                                                                                                                                             
cat $1/subs.txt | ./httpx -silent | ./anew $1/alive.txt              
                                                                                                                                                                                                                                                                                                                                                                                                                      

## Test by Xray 

for i in $(cat $1/alive.txt); do ./xray_linux_amd64 ws --basic-crawler $i --plugins xss,sqldet,xxe,ssrf,cmd-injection,path-traversal,redirect,crlf-injection --ho $(date +"%T").html ; done 
  

## test for nuclei 

cat $1/alive.txt | ./nuclei -t cent-nuclei-templates -es info,unknown -etags ssl,network | ./anew $1/nuclei.txt
