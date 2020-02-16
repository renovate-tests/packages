#!/usr/bin/env bash

case "$1" in
	"must_run" )
		if [ -r "composer.json" ]; then
			return 0
		fi
		return 1
		;;
	"is_content" )
		if [ "$2" = "vendor" ]; then
			return 1
		fi
		return 0
		;;
	"install" )
		composer.phar install
		;;
	"clean" )
		if [ -d "vendor" ]; then
			echo "Removing vendor"
			rm -fr "vendor"
		fi
		;;
esac

return 0
