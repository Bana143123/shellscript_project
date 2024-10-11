#!/bin/bash

# Function to send email alerts via Gmail
send_email() {
    SUBJECT="Website $URL is down!"
    BODY="Alert: The website $URL is unreachable as of $(date). Please check."

    {
        echo "To: devanshnarendra410@gmail.com"  # Recipient email
        echo "Subject: $SUBJECT"
        echo ""
        echo "$BODY"
    } | sendmail -v devanshnarendra410@gmail.com
    
    # Send email using sendmail
    #echo -e "Subject:$SUBJECT\n$BODY" | sendmail -v "devanshnarendra410@gmail.com"  # Replace with your Gmail address
}

# Specify the URL to check
URL="google.com"  # Replace with the website you want to monitor
echo $URL

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
        send_email  # Call the function to send an email alert
    fi
else
    echo "$(date) - Internet connection is DOWN" >> /var/log/website_monitor.log
fi
