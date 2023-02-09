#! /bin/bash
# DATE 获取日期和时间的脚本

this=_date

update() {
    time_text="$(date '+%m/%d %H:%M')"
    case "$(date '+%I')" in
        "01") time_icon="" ;;
        "02") time_icon="" ;;
        "03") time_icon="" ;;
        "04") time_icon="" ;;
        "05") time_icon="" ;;
        "06") time_icon="" ;;
        "07") time_icon="" ;;
        "08") time_icon="" ;;
        "09") time_icon="" ;;
        "10") time_icon="" ;;
        "11") time_icon="" ;;
        "12") time_icon="" ;;
    esac

    icon=" $time_icon "
    text=" $time_text "

    sed -i '/^export '$this'=.*$/d' $DWM_HOME/statusbar/temp
    printf "export %s='%s%s%s%s%s'\n" $this "$icon" "$text" >> $DWM_HOME/statusbar/temp
}

case "$1" in
    *) update ;;
esac