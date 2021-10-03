#!/bin/bash

if [ -n "$RESOLUTION" ]; then
    sed -i "s/1024x768/$RESOLUTION/" /root/supervisord.conf
fi

# start up supervisord, all daemons should launched by supervisord.
/usr/bin/supervisord -c /root/supervisord.conf

# copy terminal to depsktop
# mkdir -p /root/Desktop/
# cp -f /usr/share/applications/xfce4-terminal.desktop /root/Desktop/xfce4-terminal.desktop
# chmod +x /root/Desktop/xfce4-terminal.desktop
#echo 2 | update-alternatives --config x-terminal-emulator >> /dev/null 2>&1
# start a shell
export DISPLAY=:1
xvfb-run wine terminal64.exe /config:config.ini /portable