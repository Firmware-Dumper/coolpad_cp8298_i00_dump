#!/system/bin/sh

model=`getprop ro.product.model`
sn=`cat /sys/class/mmc_host/mmc0/mmc0:0001/serial`
#echo $model-$sn | busybox tr -d " " >  /sys/class/android_usb/android0/iSerial
#wangsheng@yulong.com comment for adb serial != ro.serial.2015.7.3

#update mute state
mute=`cat /sys/class/switch/mute_key/state`
setprop persist.sys.mutekey.switch $mute

#set yulong usb device name
iproduct=`getprop ro.yulong.usb.iproduct`
imanufacturer=`getprop ro.yulong.usb.imanufacturer`
if [ ! "x$iproduct" = "x" ]; then
    echo "$iproduct" > /sys/class/android_usb/android0/iProduct
fi
if [ ! "x$imanufacturer" = "x" ]; then
    echo "$imanufacturer" > /sys/class/android_usb/android0/iManufacturer
fi


rp=`getyl rp`

#if [ "$rp" = "1" ]; then
#    usb_func=`getprop persist.sys.usb.config`
#
#    if echo "$usb_func" | busybox grep -q adb
#    then
#     ishas=1
#    else
#	setprop persist.sys.usb.config "${usb_func},adb"
#
#    fi
#fi
