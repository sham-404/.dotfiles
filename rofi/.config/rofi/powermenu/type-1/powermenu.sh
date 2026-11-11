#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu

# Current Theme
dir="$HOME/.config/rofi/powermenu/type-1"
theme='style-1'

# CMDs
uptime="$(uptime -p | sed -e 's/up //g')"
host="$(hostname)"

# Options
shutdown=' Shutdown'
reboot=' Reboot'
lock=' Lock'
suspend=' Suspend'
logout=' Logout'
yes=' Yes'
no=' No'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "$host" \
		-mesg "Uptime: $uptime" \
		-theme "${dir}/${theme}.rasi"
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme "${dir}/${theme}.rasi"
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$suspend\n$lock\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == *"Yes"* ]]; then
		case $1 in
			shutdown)
				desktop-session-exit -s || sudo /sbin/poweroff || sudo shutdown -h now || loginctl poweroff
				;;
			reboot)
				desktop-session-exit -r || sudo /sbin/reboot || sudo shutdown -r now || loginctl reboot
				;;
			suspend)
				mpc -q pause 2>/dev/null
				amixer set Master mute 2>/dev/null
				desktop-session-exit -S || sudo zzz || pm-suspend || loginctl suspend
				;;
			logout)
				desktop-session-exit -l || icewm-session --logout || pkill -u "$USER"
				;;
		esac
	else
		exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
case "${chosen}" in
	*"Shutdown"*)
		run_cmd shutdown
		;;
	*"Reboot"*)
		run_cmd reboot
		;;
	*"Lock"*)
		desktop-session-exit -L xlock
		;;
	*"Suspend"*)
		run_cmd suspend
		;;
	*"Logout"*)
		run_cmd logout
		;;
esac
