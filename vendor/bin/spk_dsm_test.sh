test_case=$1
sleep_time=$2
wait_done=0
filename="/vendor/etc/spk_dsm_test.wav"
dsm_sleep_node="/sys/bus/i2c/devices/2-0034/dsm_sleep_duration"
top_dsm_test_node="/sys/bus/i2c/devices/2-0034/dsm_test"
bot_dsm_test_node="/sys/bus/i2c/devices/2-0035/dsm_test"
top_dsm_test_state="/sys/bus/i2c/devices/2-0034/dsm_state"
bot_dsm_test_state="/sys/bus/i2c/devices/2-0035/dsm_state"

case "$sleep_time" in
	"20")
		echo 20 > $dsm_sleep_node
		wait_done=1
	;;
	"1200")
		echo 1200 > $dsm_sleep_node
		wait_done=50
	;;
esac

case "$test_case" in
	"top")
		audio-factory-test -f enable_top-spk
		agmplay $filename -r 96000 -D 100 -d 100 -i TDM-LPAIF_VA-RX-PRIMARY-VIRT-0 &
		sleep 0.1
		cat $top_dsm_test_node
		audio-factory-test -f disable_top-spk
		echo top-spk:
		cat $top_dsm_test_state
		;;
	"bot")
		audio-factory-test -f enable_bot-spk
		agmplay $filename  -r 96000 -D 100 -d 100 -i TDM-LPAIF_VA-RX-PRIMARY-VIRT-0 &
		sleep 0.1
		cat $bot_dsm_test_node
		audio-factory-test -f disable_bot-spk
		echo bot-spk:
		cat $bot_dsm_test_state
		;;
	"all")
		echo "test all spk"
		audio-factory-test -f enable_spk
		agmplay $filename  -r 96000 -D 100 -d 100 -i TDM-LPAIF_VA-RX-PRIMARY-VIRT-0 &
		sleep 0.3
		cat $bot_dsm_test_node &
		cat $top_dsm_test_node &
		echo "wait"
		sleep $wait_done
		audio-factory-test -f disable_spk
		echo top-spk:
		cat $top_dsm_test_state
		echo bot-spk:
		cat $bot_dsm_test_state
	;;
esac
killall agmplay
