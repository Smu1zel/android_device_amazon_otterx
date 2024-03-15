#!/bin/sh

# Call up to otter-pvr
./extract-files-pvr.sh

VENDOR=amazon
DEVICE=otterx

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary

echo "Pulling $DEVICE files..."
for FILE in `cat proprietary-files.txt | grep -v ^# | grep -v ^$`; do
DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
mkdir -p $BASE/$DIR
    fi
cp /run/media/lynden/Data/system_dump/system/$FILE $BASE/$FILE
done

./setup-makefiles.sh
