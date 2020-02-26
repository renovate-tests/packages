#!/usr/bin/env bash

SELF_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

SRC="$1"
DST="$2"
shift
shift

$SELF_DIR/jh-rsync.sh \
	"$SRC/" "$DST" \
	--progress \
	--one-file-system \
	--no-owner --no-group  --chmod=ugo=rwX \
	--delete --delete-excluded \
	--filter ": .jhrsync-filter" \
	--filter ":- .gitignore" \
	"$@"
