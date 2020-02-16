#!/usr/bin/env bash

if [ "$1" = "" ]; then
	echo "Usage: $0 <device>"
	exit 255
fi

awk -v needle="$1" '$1==needle {print $2}' /proc/mounts
