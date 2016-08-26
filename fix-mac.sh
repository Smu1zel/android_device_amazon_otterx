#!/system/bin/sh

PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
ORIG_NVS_BIN=/system/etc/firmware/ti-connectivity/wl1271-nvs_127x.bin
NVS_BIN=/data/misc/wifi/wl1271-nvs.bin

if [ ! -f "$NVS_BIN" ]; then
    cp ${ORIG_NVS_BIN} ${NVS_BIN}
    calibrator set nvs_mac $NVS_BIN $(getprop ro.boot.wifimac | sed 's/../&:/g;s/:$//')
    chmod 644 ${NVS_BIN}
fi

insmod /system/lib/modules/wl12xx_sdio.ko
