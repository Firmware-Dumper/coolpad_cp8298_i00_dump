#!/system/xbin/sh

FILE=/cache/recovery/command
FILE1=/cache/recovery/udisk_erase_for_gps
FILE2=/cache/recovery/udisk_erase

/system/bin/get_GMSdownload

val0=$?

if [ "$val0" = "1" ]
then
  /system/bin/enter_recovery

  val1=$?
  if [ "$val1" = "0" ]
  then
    echo "enter_recovery OK!"
  fi

  /system/bin/set_GMSdownload

  val2=$?
  if [ "$val2" = "0" ]
  then
    echo "set_GMSdownload OK!"
  fi


  rm $FILE1
  rm $FILE2

  echo "--wipe_data" >>$FILE
  echo `date` >>$FILE2

  reboot
else
  echo " GMSdownload is not need wipe date"
fi
