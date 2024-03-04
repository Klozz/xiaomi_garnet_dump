outpath="/data/vendor/audio/elliptic_calib_v2"
dbgpath="/data/vendor/audio/elliptic_debug_dump"
cpypath="/mnt/vendor/persist/audio/us_cal_v2"
funcCreateFile(){
	if [ ! -f $1 ];then
		for i in  {1..5};do
			touch $1
			chmod 777 $1
			if [ -f $1 ];then
				break
			fi
		done
		if [ ! -f $1 ];then
			echo "create $1 error"
			exit
		fi
	fi
}

funcCreateFile $outpath
funcCreateFile $dbgpath


target=`getprop ro.build.product`
if [ "$target" = "garnet" ]; then

if [ "$1" = "start" ]; then
EL_calib
fi

if [ "$1" = "far2near" ]; then
killall -s SIGUSR1 EL_calib
fi

if [ "$1" = "near2far" ]; then
killall -s SIGUSR2 EL_calib
fi

if [ "$1" = "stop" ]; then
killall -s SIGINT EL_calib
cp "$outpath" "$cpypath"
fi

fi
