#!/usr/bin/env bash

set -e

export PATH=/sbin:/usr/sbin:/bin:/usr/bin

mkdir -p /etc/jehon/repo

if [ -r /etc/jehon/repo/Packages ]; then
	HASH_BEFORE=$( sha256sum /etc/jehon/repo/Packages )
fi

/usr/bin/rsync --recursive --times \
		--itemize-changes \
		--modify-window=2 \
		--delete \
		synology-auto:/repo /etc/jehon/


if [ ! -r /etc/apt/sources.list.d/jehon-etc-repo.list ]; then
	echo "deb [trusted=yes] file:///etc/jehon/repo /" > /etc/apt/sources.list.d/jehon-etc-repo.list
fi

HASH_AFTER=$( sha256sum /etc/jehon/repo/Packages )

if [ "$HASH_BEFORE" != "$HASH_AFTER" ]; then
	apt update
fi
