#!/bin/bash

# Function to send email using Yahoo's SMTP
send_email() {
    SUBJECT="Website $URL is down!"
    BODY="Alert: The website $URL is unreachable as of $(date). Please check."
    
    # Use a valid 'From' email address
    echo -e "To: anikett@spanidea.com\nFrom: narendrakumarb@spanidea.com\nSubject: $SUBJECT\n\n$BODY" | ssmtp thakareani003@gmail.com
    #echo -e "Subject: Test Email\nThis is a test email" | ssmtp devanshnarendra410@gmail.com

}

# Specify the URL to check
URL="reddy.com"
interval=60
while true;
do
# Check internet connection first
    ping -c 1 -w 2 8.8.8.8 > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "$(date) - Internet connection is UP, now checking website status" >> /var/log/website_monitor.log
    
    # Check the specified website
        ping -c 1 -w 2 $URL > /dev/null 2>&1
    
        if [ $? -eq 0 ]; then
            echo "$(date) - Website $URL is UP" >> /var/log/website_monitor.log
        else
            echo "$(date) - Website $URL is DOWN" >> /var/log/website_monitor.log
            send_email 
        fi
    else
        echo "$(date) - Internet connection is DOWN" >> /var/log/website_monitor.log
    fi
    sleep $interval
    echo "Waiting for $interval secs and retry for checking"
done