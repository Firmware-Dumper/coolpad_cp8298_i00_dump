#!/system/bin/sh


dm=`getyl dm`
type=`getprop ro.build.type`
#102:XW ,100:LC, 101:RW
version=`getprop ro.yulong.version.tag`
first_boot=`getprop persist.boot.first`
hallisopen=`getprop sys.yulong.openhall`
######################add  for hall when firs reboot #######################################
if [ "$hallisopen" = 1 ]; then
     echo "window" > /sys/devices/virtual/touchscreen/touchscreen_dev/mode
fi

if [ "$dm" = "0" ]; then
   # am broadcast -a com.mediatek.mtklogger.ADB_CMD -e cmd_name start --ei cmd_target 7
   # am broadcast -a com.mediatek.mtklogger.ADB_CMD -e cmd_name stop --ei cmd_target 7
     
     log -p I -t BootComplete "start mtklogger!!!"
fi
