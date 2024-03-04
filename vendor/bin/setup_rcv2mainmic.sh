# tinyplay file.wav [-D card] [-d device] [-p period_size] [-n n_periods]
# sample usage: playback.sh 2000.wav  1
set -x

sleep 1

echo "enabling main mic"
audio-factory-test -f enable_main-mic

# start recording
agmcap /data/data/rcv2main_mic.wav -r 48000 -b 16 -c 2 -T 4 -p 1024 -n 4 -D 100 -d 101 -i CODEC_DMA-LPAIF_RXTX-TX-3 && echo "capture done" &



sleep 1
echo "enabling receiver"
audio-factory-test -f enable_receiver
agmplay /vendor/etc/rcv_seal.wav -D 100 -d 100 -i TDM-LPAIF_VA-RX-PRIMARY-VIRT-0
sleep 1


echo "disabling main mic"
audio-factory-test -f disable_main-mic

echo "disabling receiver"
audio-factory-test -f disable_receiver

