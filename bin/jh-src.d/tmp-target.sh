#!/usr/bin/env bash

L=( "tmp" "target" )

case "$1" in
	"must_run" )
		for i in "${L[@]}"; do
			if [ -d "$i" ]; then
				return 0
			fi
		done
		return 1
		;;
	"is_content" )
		# Invert result
		for i in "${L[@]}"; do
			if [ "$i" = "$2" ]; then
				return 1
			fi
		done
		return 0
		;;
	"clean" )
		for i in "${L[@]}"; do
			if [ -d "$i" ]; then
				echo "Removing $i"
				rm -fr "$i"
			fi
		done
		;;
esac

return 0
