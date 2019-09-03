# check_sap_backup

```

-> Importe este script para /usr/lib/zabbix/externalscripts.
"check_sap_backup.sh"

-> Importe este arquivo para /etc/sudoers.d
"check_sap"

-> Crie um link simbolico em /sbin para o comando hdbsql
--> Para encontrar o hdbsql use:
"find / -name hdbsql"
"ln -s /HANA/PRD/exe/linuxx86_64/HDB_1.00.121.00.1466466057_2994339/hdbsql /sbin/hdbsql"

-> Importe este arquivo para /etc/zabbix/zabbix_agentd.d
"check_sap.conf"

-> Importe este template no seu servidor Zabbix.
"Template Template SAP Backup.xml"


O Template possue as Macro que serão ajustada conforme os dados do host.

{$BCO} = PRD
{$ID} =  00
{$PASS} = passwd

Script via linha de comando.

--> backup status indexserver/xsengine
check_sap.sh 00 passwd PRD backup indexserver

--> backup data ultimo backup_last indexserver/xsengine
check_sap.sh 00 passwd PRD backup indexserver
```
