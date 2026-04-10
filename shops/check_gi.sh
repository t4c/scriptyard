#!/bin/bash

# Path to your python script
SCRIPT_PATH="/home/user/my_progressbjj_gi.py"
EMAIL="user@domain.tld"

# SMTP Data
SMTP_SERVER="mail.domain.tld"
SMTP_PORT=587
SMTP_USER="user@domain.tld"
SMTP_PASS="password"

RESULT=$(python3 "$SCRIPT_PATH")

if echo "$RESULT" | grep -q "AVAILABLE"; then
    echo "Gi found! Sending SMTP mail..."
    python3 - <<EOF
import smtplib
from email.message import EmailMessage

msg = EmailMessage()
msg.set_content("""$RESULT""")
msg['Subject'] = 'Progress BJJ Stock Alert'
msg['From'] = '$SMTP_USER'
msg['To'] = '$EMAIL'

try:
    with smtplib.SMTP('$SMTP_SERVER', $SMTP_PORT) as s:
        s.starttls()
        s.login('$SMTP_USER', '$SMTP_PASS')
        s.send_message(msg)
    print("Mail sent successfully.")
except Exception as e:
    print(f"Failed to send mail: {e}")
EOF
fi
