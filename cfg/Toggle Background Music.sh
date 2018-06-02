#!/usr/bin/env bash
stop_bgm(){
        touch /home/pigaming.DisableMusic
    clear
        echo -e "\n\n\n                               Background Music Stopped\n\n\n"
        sleep 3
}

start_bgm(){
        rm /home/pigaming.DisableMusic
        echo -e "\n\n\n                                    Background Music Started\n\n\n"
        sleep 3
}

if [ -e /home/pigaming.DisableMusic ]; then
        start_bgm
else
        stop_bgm
fi
exit
