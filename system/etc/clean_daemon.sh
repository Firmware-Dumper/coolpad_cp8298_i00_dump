#!/system/bin/sh
# Forbidden auto start service.
# writen at 2014.07.21
# 
#=================================[START]===================================== 
    
#LOG_NAME="${0}:"
LOG_TAG="YLLOG:CLEANDAEMON "


# The log function 
logd ()
{
  /system/bin/log -t $LOG_TAG -p d "$LOG_NAME $@"
}

forbidden_package=`busybox grep "name" /data/system/forbidden_autorun_packages.xml | busybox awk '{print $2}' | busybox cut -f 2 -d '"'`
forbidden_apk=""
for package in $forbidden_package
do
  forbidden_apk=${forbidden_apk}" "`busybox grep $package /data/system/packages.xml | busybox grep "\.apk" | busybox awk '{print $3}' | busybox cut -f 2 -d '"' | busybox cut -f 4 -d '/'`
done

pidstr=`ps | busybox awk '$3 == 1' | busybox grep -v "\/system\/bin"| busybox grep -v "\/sbin" | busybox grep -v "zygote" | busybox grep -v "system_server" | busybox awk '{print $2}'`

killed="false"

for pid in $pidstr
do
    killed="false"
    proc_name=`ps $pid | busybox grep "$pid" | busybox awk '{print $9}'`
    for pakcage in $forbidden_package
    do
        pakcage_scan=`echo $proc_name | grep $pakcage`
        if [[ $pakcage_scan != "" ]]
        then
            orphan_sub_procs_id=$pid" "`ps | busybox awk '$3 == '$pid'' | busybox awk '{print $2}'`
            kill $orphan_sub_procs_id
            logd clean $pakcage daemon $orphan_sub_procs_id
            killed="true"
        fi
    done

    if [ $killed == "true" ]
    then
        continue
    fi

    for apk in $forbidden_apk
    do
        apks_can=`echo $proc_name | grep $apk`
        if [[ $apks_can != "" ]]
        then
            orphan_sub_procs_id_=$pid" "`ps | busybox awk '$3 == '$pid'' | busybox awk '{print $2}'`
            kill $orphan_sub_procs_id_
            logd clean $pakcage daemon $orphan_sub_procs_id_
        fi
    done
done

exit 0
#===================================[END]=====================================
