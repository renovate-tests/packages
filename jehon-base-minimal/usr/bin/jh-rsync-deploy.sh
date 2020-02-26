#!/usr/bin/env bash

SELF_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

SRC="$1"
DST="$2"
shift
shift

$SELF_DIR/jh-rsync.sh \
	"$SRC" "$DST" \
	--delete --max-delete=1000 --delete-excluded \
	--perms \
	--exclude ".git" \
	--exclude "tmp" \
	"$@"
