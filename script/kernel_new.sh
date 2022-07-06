#!/bin/bash
# Author: Jeff <jeff@jeffok.com>
# Centos 7 内核

Logfile="/data/logs/wget.log"
Date=`date +"%F %T"`
echo "${Date}" >> ${Logfile}
options='-N -r -np -nd -nH -t 5 -T 30 -R *.htm* --limit-rate=5m -e robots=off --no-check-certificate'

wget $options "https://mirror.xtom.com.hk/centos-altarch/7/kernel/x86_64/Packages/" -P /data/mirrors/kernel-5.4 &>> ${Logfile}

echo '#######################END#####################' >> ${Logfile}