event=`getevent -p |grep "Headset Jack" -C1 |awk '/device/{print $4}'`
getevent -s4 $event
