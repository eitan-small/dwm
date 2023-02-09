#! /bin/bash
# VOL 音量脚本

this=_vol

update() {
    volunmuted=$(amixer get Master | awk -F '[][]' '/Mono:/ { print $6 }')
    vol_text=$(amixer get Master | awk -F '[][%]' '/Mono:/ { print $2 }')
    if [ "$volunmuted" = "off" ];  then vol_icon="ﱝ";
    elif [ "$vol_text" -eq 0 ];  then vol_text="00"; vol_icon="婢";
    elif [ "$vol_text" -lt 10 ]; then vol_icon="奔"; vol_text=0$vol_text;
    elif [ "$vol_text" -le 50 ]; then vol_icon="奔";
    else vol_icon="墳"; fi

    icon=" $vol_icon "
    text=" $vol_text% "

    sed -i '/^export '$this'=.*$/d' $DWM_HOME/statusbar/temp
    printf "export %s='%s%s%s%s%s'\n" $this "$icon" "$text" >> $DWM_HOME/statusbar/temp
}

case "$1" in
    *) update ;;
esac
