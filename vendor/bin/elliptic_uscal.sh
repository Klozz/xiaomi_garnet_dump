#enable device
outpath="/data/elliptic"
cpypath="/mnt/vendor/persist/us_cal_v2"
if [ !-d"$outpath" ]; then
mkdir "$outpath"
fi

target=`getprop ro.build.product`

mode=1065
if [ "$target" = "zizhan" ]; then
mode=1131
fi

if [ "$target" = "diting" ]; then
mode=1080
fi

if [ "$target" = "mondrian" ]; then
mode=1080
fi

if [ "$target" = "yudi" ]; then
mode=1080
fi

if [ "$target" = "garnet" ]; then
mode=1063
fi

if [ "$target" = "liuqin" ]; then
mode=1080
fi

if [ !-d"$cpypath" ]; then
mkdir "$cpypath"
fi

if [ "$1" = "start" ]; then
audio-factory-test -f enable_ultrasound
audio-factory-test -f enable_ultrasound_mic
cd /vendor/bin/ && /vendor/bin/engine_runner -m $mode -d -p -c -o /data/elliptic/
fi

#far away
if [ "$1" = "near2far" ]; then
killall -INT engine_runner
fi

#come near
if [ "$1" = "far2near" ]; then
killall -INT engine_runner
fi

#finish calibration
if [ "$1" = "stop" ]; then
killall -INT engine_runner

#copy cali data
cp /data/elliptic/calibration_v2.txt /mnt/vendor/persist/audio/us_cal_v2

#disable
audio-factory-test -f disable_ultrasound
audio-factory-test -f disable_ultrasound_mic
fi

