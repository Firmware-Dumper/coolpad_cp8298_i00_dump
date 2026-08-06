#!/system/bin/sh
  echo 1 > /sys/module/sec/parameters/recovery_done		#koshi   
if ! applypatch -c EMMC:recovery:9588736:ea8907cb5ebcbd84b6188d568627438462358110; then
  log -t recovery "Installing new recovery image"
  applypatch -b /system/etc/recovery-resource.dat EMMC:boot:7716864:efd23a7a52cbf9572153595f56ff41ea2cb585c5 EMMC:recovery ea8907cb5ebcbd84b6188d568627438462358110 9588736 efd23a7a52cbf9572153595f56ff41ea2cb585c5:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
  if applypatch -c EMMC:recovery:9588736:ea8907cb5ebcbd84b6188d568627438462358110; then		#koshi
	echo 0 > /sys/module/sec/parameters/recovery_done		#koshi
        log -t recovery "Install new recovery image completed"
        
  if applysig /system/etc/recovery.sig recovery; then
    sync
    log -t recovery "Apply recovery image signature completed"
  else
    log -t recovery "Apply recovery image signature fail!!"
  fi

    
  else
	echo 2 > /sys/module/sec/parameters/recovery_done		#koshi
        log -t recovery "Install new recovery image not completed"
  fi
else
  echo 0 > /sys/module/sec/parameters/recovery_done         #koshi
  log -t recovery "Recovery image already installed"
fi
if ! applypatch -c EMMC:tee2:425984:09956fdf55d1f5f563d75c06bbc1bf7281729816; then
  log -t recovery "Installing new t-base image"
  applypatch -t /system/etc/trustzone.bin EMMC:tee2:425984:09956fdf55d1f5f563d75c06bbc1bf7281729816 
else
  log -t recovery "t-base image already installed"
fi
