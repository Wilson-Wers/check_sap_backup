#!/bin/bash

##################################################################
# Script: check_sap_backup.sh                                    #
# Author: Wilson Fernandes                                       #
# Contact: Email: wilsonwers@gmail.com                           #
# Date: 2019-08-15                                               #
# Description: Monitoramento backup SAP                          #
# Use: check_sap_backup.sh 00 passwd BWP backup xsengine         #
##################################################################

ID=${1}
PASS=${2}
BCO=${3}
CMD=${4}
ARG=${5}
HOST=$(cat /etc/hostname)

case ${CMD} in

backup)
command="select state_name from SYS.M_BACKUP_PROGRESS where service_name = '${ARG}'"
out="$(sudo /sbin/hdbsql -a -n ${HOST} -i ${ID} -u SYSTEM -p ${PASS} <<EOF
$command ;
exit
EOF
)"
resp=$(echo "$out" | sed '1,6d' | sed '$d')
[ "$resp" == '"successful"' ] && echo "0" | tail  -n1  || echo "1" | tail -n1
exit 0
;;

backup_last)
command="select SYS_END_TIME from SYS.M_BACKUP_PROGRESS where service_name = '${ARG}'"
out="$(sudo /sbin/hdbsql -a -n ${HOST} -i ${ID} -u SYSTEM -p ${PASS} <<EOF
$command ;
exit
EOF
)"
resp=$(echo "$out" | sed '1,6d' | sed '$d' | sed 's/\"//' | cut -d"." -f1)
echo $resp
;;
*)
echo "ZBX_NOTSUPPORTED: Unsupported item key."
exit 1
;;

esac
