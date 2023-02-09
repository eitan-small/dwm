#! /bin/bash

touch $DWM_HOME/statusbar/temp

# 设置某个模块的状态 update cpu mem ...
update() {
    [ ! "$1" ] && refresh && return                                      # 当指定模块为空时 结束
    bash $DWM_HOME/statusbar/packages/$1.sh                                   # 执行指定模块脚本
    shift 1; update $*                                                   # 递归调用
}

# 更新状态栏
refresh() {
    _date='';   # 重置所有模块的状态为空
    source $DWM_HOME/statusbar/temp                                           # 从 temp 文件中读取模块的状态
    xsetroot -name "$_wifi$_vol$_date"             # 更新状态栏
}

# 启动定时更新状态栏 不同的模块有不同的刷新周期 注意不要重复启动该func
cron() {
    let i=0
    while true; do
        to=()                                                           # 存放本次需要更新的模块
        [ $((i % 10)) -eq 0 ]  && to=(${to[@]} wifi)                    # 每 10秒  更新 wifi
        [ $((i % 20)) -eq 0 ]  && to=(${to[@]} vol)                     # 每 20秒  更新 cpu mem vol icons
        [ $((i % 5)) -eq 0 ]   && to=(${to[@]} date)                    # 每 5秒   更新 date
        [ $i -lt 30 ] && to=(wifi date vol)                             # 前 30秒  更新所有模块
        update ${to[@]}                                                 # 将需要更新的模块传递给 update
        sleep 5; let i+=5
    done &
}

# cron 启动定时更新状态栏
# update 更新指定模块 `update cpu` `update mem` `update date` `update vol` `update bat` 等
# updateall 更新所有模块 | check 检查模块是否正常(行为等于updateall)
case $1 in
    cron) cron ;;
    update) shift 1; update $* ;;
    updateall|check) update icons wifi cpu mem date vol bat ;;
esac