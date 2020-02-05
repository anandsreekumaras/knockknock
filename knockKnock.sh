#!/bin/bash
# knockKnock is tool to extract working IP address or hosts from list of URLs or IPs
# written by Anand A S https://anandsreekumar.com
filename='hosts.txt' 
filelines=`cat $filename`
for line in $filelines ; do
	export HOST=$line
	STATUS=$(timeout 2s curl -s -o /dev/null -w '%{http_code}' ${HOST})
	if [ $STATUS -eq 200 ] || [ $STATUS -eq 301 ] || [ $STATUS -eq 302 ] || [ $STATUS -eq 400 ] || [ $STATUS -eq 403 ] || [ $STATUS -eq 404 ] || [ $STATUS -eq 500 ]; then
		RDR=$(curl -Ls -o /dev/null -w '%{url_effective}' ${HOST})
		REFERER=$(curl -Ls -o /dev/null -w '%{url_effective}' ${RDR})
		echo "HOST:   $HOST   STATUS:   $STATUS   REFERER:    $REFERER"
	
		fi
		
done
notify-send Knock Knock finished $filename
