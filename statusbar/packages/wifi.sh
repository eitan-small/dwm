#! /bin/bash

this=_wifi

update() {
    wifi_icon=""
    wifi_text=$(nmcli | grep 已连接 | awk '{print $3}')
    [ "$wifi_text" = "" ] && wifi_text="未连接"

    icon=" $wifi_icon "
    text=" $wifi_text "

    sed -i '/^export '$this'=.*$/d' $DWM_HOME/statusbar/temp
    printf "export %s='%s%s%s%s%s'\n" $this "$icon" "$text" >> $DWM_HOME/statusbar/temp
}

case "$1" in
    *) update ;;
esac