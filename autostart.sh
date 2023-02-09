#!/bin/bash
# DWM自启动脚本

settings() {
    [ $1 ] && sleep $1
}

daemons() {
    [ $1 ] && sleep $1
    $DWM_HOME/statusbar/statusbar.sh cron &        # 开启状态栏定时更新
    fcitx5 &                                  # 开启输入法
    flameshot &                               # 截图要跑一个程序在后台 不然无法将截图保存到剪贴板
    dunst -conf ~/scripts/config/dunstrc & # 开启通知server
    picom --config ~/scripts/config/picom.conf >> /dev/null 2>&1 & # 开启picom
}

cron() {
    [ $1 ] && sleep $1
    let i=0
    while true; do
        [ $((i % 300)) -eq 0 ] && feh --randomize --bg-fill ~/Pictures/wallpaper/* # 每300秒更新壁纸
        sleep 10; let i+=10
    done
}

settings 1 &                                  # 初始化设置项
daemons 3 &                                   # 后台程序项
cron &                                      # 定时任务项
