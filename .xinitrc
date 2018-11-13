#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi


# start programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

setxkbmap -layout 'us,us' -variant ',altgr-intl' 
setxkbmap -option 'grp:alt_shift_toggle' 
xbacklight -set 40 &
nitrogen --restore &
redshift &
# compton &
# compton --backend=glx --vsync=opengl &
# compton -f -o "0.5" -m "1" -e "1" -D "3" -c -C -r "26" -l "-39" -t "-25" --shadow-red "0.05" --shadow-green "0.05" --shadow-blue "0.05" &
# exec i3
dwmstatus 2>&1 >/dev/null &
exec dwm
