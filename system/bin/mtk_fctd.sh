#!/system/bin/sh
sleep 2
start fastmmi
if [ ! -e /data/fastmmi ]; then 
    busybox mkfifo -m 666 /data/fastmmi
fi


if [ ! -e /data/fastmmi_out ]; then 
    busybox mkfifo -m 666 /data/fastmmi_out
fi