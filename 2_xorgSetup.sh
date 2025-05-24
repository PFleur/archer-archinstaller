#!/usr/bin/env bash
echo -e "\033[91m╓───────────────────────────────────────────────────────┐"
echo -e "║       _____________________    __  ______________     │"
echo -e "║      ╱  ╲│  __  │ │  _____│\033[31m│\033[91m  │ │ │  ____│  __  │     │"
echo -e "║     ╱ ╱╲ ╲ │\033[31m│\033[91m │ │ │ │\033[31m│\033[91m  │ │\033[31m│\033[91m  │ │ │ │\033[31m│\033[91m   │ │\033[31m│\033[91m │ │     │"
echo -e "║    ╱ ╱__╲ ╲│__│ │ │ │\033[31m│\033[91m  │ │___│ │ │ │___ │ │__│ │     │"
echo -e "║   ╱ ______ ╲___ ╲ │ │\033[31m│\033[91m  │  ___  │ │  __│ │ ____ ╲     │"
echo -e "║  ╱ ╱\033[31m╱\033[91m     ╲ ╲  ╲ ╲│ │___│ │\033[31m│\033[91m  │ │ │ │____│ │\033[31m│\033[91m  ╲ ╲    │"
echo -e "║ ╱_╱\033[31m╱\033[91m       ╲_╲  ╲_╲_____│_│\033[31m│\033[91m  │_│ │______│_│\033[31m│\033[91m   ╲_╲   │"
echo -e "║ Arch Linux Setup and Config Script by Patchouli Fleur │"
echo -e "║ System Installation                                   │"
echo -e "╚═══════════════════════════════════════════════════════╛\033[0m"

echo "Setting up graphical environment..."
echo ""

echo "Generating .xinitrc file..."

cat <<EOF > ${HOME}/.xinitrc
  #!/bin/bash

  xrdb="xrdb"
  xinitdir="/etc/X11/xinit"
  xmodmap="xmodmap"
  inputManager="fcitx"

  userresources="$HOME/.Xresources"
  usermodmap="$HOME/.Xmodmap"
  sysresources="$xinitdir/.Xresources"
  sysmodmap="$xinitdir/.Xmodmap"

  export PATH="${PATH}:${HOME}/.bin"
  export EDITOR="nvim"
  export TERM="kitty"
  export GTK_IM_MODULE="${inputManager}"
  export QT_IM_MODULE="${inputManager}"
  export XMODIFIERS=@im="${inputManager}"

  # Disable Bell
  xset -b

  # merge in defaults and keymaps

  if [ -f "$sysresources" ]; then
      if [ -x /usr/bin/cpp ] ; then
    "$xrdb" -merge "$sysresources"
      else
    "$xrdb" -nocpp -merge "$sysresources"
      fi
  fi

  if [ -f "$sysmodmap" ]; then
      "$xmodmap" "$sysmodmap"
  fi

  if [ -f "$userresources" ]; then
      if [ -x /usr/bin/cpp ] ; then
    "$xrdb" -merge "$userresources"
      else
    "$xrdb" -nocpp -merge "$userresources"
      fi
  fi

  if [ -f "$usermodmap" ]; then
      "$xmodmap" "$usermodmap"
  fi

  # start some nice programs

  if [ -d "$xinitdir"/xinitrc.d ] ; then
    for f in "$xinitdir/xinitrc.d"/?*.sh ; do
      [ -x "$f" ] && . "$f"
    done
    unset f
  fi

  ~/.fehbg &
  
  while true; do
    WF=$(nmcli -f IN-USE,SIGNAL,SSID device wifi | awk '/^\*/{if (NR!=1) {print $2}}')
    #LOCALTIME=$(date +%Z\=%Y-%m-%d', '%H:%M)
    LOCALTIME=$(date +%Y-%m-%d', '%H:%M)
    if acpi -a | grep off-line >/dev/null; then
      BAT="bat. $(acpi -b | awk '{ print $4 }' | tr -d ',')"
      xsetroot -name " $BAT | Wifi: $WF | $LOCALTIME "
    else
      xsetroot -name " Wifi: $WF | $LOCALTIME "
    fi
    sleep 1s
  done &

  exec dwm
EOF

echo "Generating xmodmap..."

cat <<EOF > ${HOME}/.xmodmap
  remove mod1 = Alt_R
EOF
