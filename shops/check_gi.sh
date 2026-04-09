#!/bin/bash

SCRIPT_PATH="/home/user/need_a_gi.py"
EMAIL="your@email.com"

RESULT=$(python3 "$SCRIPT_PATH")

if echo "$RESULT" | grep -q "AVAILABLE"; then
    echo "Stock found! Sending email to $EMAIL"
    echo -e "Subject: Progress BJJ Stock Alert\n\n$RESULT" | sendmail "$EMAIL"
fi
