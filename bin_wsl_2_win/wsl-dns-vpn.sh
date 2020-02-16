#!/usr/bin/env bash

# https://docs.microsoft.com/en-us/windows/wsl/troubleshooting

set -e

SELF="$(realpath "$0")"

if [ $(whoami) != "root" ]; then
	echo "Restarting as root"
	sudo "$SELF" "$@"
	exit 0
fi

BACKUP=/tmp/vpn/resolv.conf.without-vpn
DIR="$(dirname "$BACKUP")"

mkdir -p "$DIR"
chown root.root "$DIR"
chmod 755 "$DIR"

vpn() {
	echo "Hacking resolv.conf file"
	cp /etc/resolv.conf "$BACKUP"
	unlink /etc/resolv.conf
	grep -v "^#" $BACKUP \
		| grep -v "192." \
		> /etc/resolv.conf
}

restore() {
	if [ ! -r "$BACKUP" ]; then
		echo "Backup file not found, not restoring" >&2
		exit 255
	fi
	echo "Restoring resolv.conf file"
	cp "$BACKUP" /etc/resolv.conf
	rm "$BACKUP"
}

force() {
	echo "Forcing going back to a theoritical state"
	ln -f -s ../run/resolvconf/resolv.conf /etc/resolv.conf
}


case "$1" in
	"vpn" )
		vpn
		;;
	"restore" )
		restore
		;;

	"force" )
		force
		;;
	"debug" )
		echo "*** [etc] link ? ***"
		ls -l /etc/resolv.conf
		echo "*** [etc] content ***"
		cat /etc/resolv.conf

		if [ -r "$BACKUP" ]; then
	                echo "*** [backup] link ? ***"
	                ls -l "$BACKUP"
	                echo "*** [backup] content ***"
	                cat "$BACKUP"
		else
			echo "*** [backup] not found"
		fi
		;;
	"" )
		if [ -r "$BACKUP" ]; then
			restore
		else
			hack
		fi
		;;
esac
