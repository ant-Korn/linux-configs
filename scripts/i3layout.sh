#!/bin/bash

#Shell scipt to prepend i3status with more stuff

i3status --config /etc/i3status.conf | while :
do
    read line
    LG=$(xkb-switch | cut -c -2)
    if [ $LG == "us" ]
    then
        dat="[{ \"full_text\": \"LANG: $LG\", \"color\":\"#00FF00\" },"
    else
        dat="[{ \"full_text\": \"LANG: $LG\", \"color\":\"#FF0000\" },"
    fi
        echo "${line/[/$dat}" || exit 1
done

