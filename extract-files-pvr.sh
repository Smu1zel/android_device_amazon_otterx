#!/bin/sh

VENDOR=amazon
DEVICE=otterx

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary

echo "Pulling $DEVICE files..."
for FILE in `cat proprietary-files-pvr.txt | grep -v ^# | grep -v ^$`; do
DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
mkdir -p $BASE/$DIR
    fi
adb pull /system/$FILE $BASE/$FILE
done

./setup-makefiles-pvr.sh
