#!/bin/bash

function run {
  if ! pgrep -x $(basename $1 | head -c 15) 1>/dev/null;
  then
    $@&
  fi
}

#start the conky to learn the shortcuts
conky &

#start sxhkd to replace Qtile native key-bindings
run sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc 


#starting utility applications at boot time
run nm-applet
run pamac-tray
run xfce4-power-manage
numlockx on
blueberry-tray
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
/usr/lib/xfce4/notifyd/xfce4-notifyd

#starting user applications at boot time
run volumeicon &
run ~/.config/polybar/launch.sh &
#run discord &
#nitrogen --restore &
#run caffeine -a &
#run vivaldi-stable &
#run firefox &
#run thunar &
#run dropbox &
#run insync start &
#run spotify &
#run atom &
#run telegram-desktop &
