# Java环境变量
export JAVA_HOME=/home/cieanyau/WorkSpase/Java/Java8-1 
export PATH=$JAVA_HOME/bin:$PATH 
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar


export http_proxy="http://127.0.0.1:20171"
export https_proxy="http://127.0.0.1:20171"

export RANGER_LOAD_DEFAULT_RC FLASE

# 解决中文乱码问题
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US

#fcitx 输入法问题
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# 解决Java程序无法正常显示的BUG
export _JAVA_AWT_WM_NONREPARENTING=1
exec $1
wmname LG3D

#dcitx
fcitx &

#声卡
pulseaudio &

#bash
/bin/bsh /home/cieanyau/scripts/wp-update.sh

while true; 
do
left=$(acpi | cut -d, -f2 | cut -d" " -f2)
status=$(acpi -a | cut -d- -f1 | cut -d: -f2 | cut -d" " -f2)
if [ $status = "off" ];then
    status='未充电'
else
    status='充电中'
fi
month=$(date | cut -d" " -f2)
date=$(date | cut -d" " -f3)
week=$(date | cut -d" " -f4)
time=$(date | cut -d" " -f5)

light=$(xbacklight -get)
mute=$(amixer get Master | sed -n '$p' | cut -d[ -f4 | cut -d"]" -f1)
alsa=$(amixer get Master | sed -n '$p' | cut -d] -f1 | cut -d"[" -f2)
if [ $mute = "off" ];then
    alsa='静音'
fi
xsetroot -name "$month-$date $week $time [音量:$alsa][亮度:$light%][$status]:$left"
sleep 1s

done &

#picom
picom &

#flameshot
flameshot &

# dwm
exec dwm
