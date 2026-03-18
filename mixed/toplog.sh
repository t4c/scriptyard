#!/bin/sh
# Toplog - Simple shellscript for debugging server crashes
# rewritten by Milan 't4c' Berger 2006
#
# Distributed under the terms of the GNU General Public License v2

[ "$UID" -ne "0" ] && echo "Must be root to run this script." &&
     exit

mkdir -p /root/toplog
(
cat <<'EOF'
#!/bin/bash
export TERM="vt100"
export PATH="/bin:/usr/bin"
LOGFILE="/root/toplog/"`date "+%Y%m%d-%H%M"`".log.gz"

cd /root/toplog/
top -bn1 | gzip > $LOGFILE
rm `date --date "4 days ago" "+%Y%m%d"`-*.log.gz &>/dev/null
EOF
) > /root/toplog/cronjob.sh
chmod 700 /root/toplog/cronjob.sh
(
echo
echo "# Toplog - Simple shellscript for debugging server crashes"
echo "*  *  * * *     root  /root/toplog/cronjob.sh &> /dev/null"
) >> /etc/crontab
