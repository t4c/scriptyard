#!/bin/bash
# marks 1.000.000 Blocks as badblock :)
# you should really know what you're doing my friend

hdparm=`which hdparm`
count=0
while [ $count -le 1000000 ]
      do
      $hdparm --yes-i-know-what-i-am-doing --make-bad-sector $count /dev/sda
      count=$[$count+1]
      done
exit 0 
