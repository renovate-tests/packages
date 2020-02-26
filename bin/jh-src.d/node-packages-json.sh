#!/usr/bin/env bash

case "$1" in
	"must_run" )
		if [ -r "package.json" ]; then
			return 0
		fi
		return 1
		;;
	"is_content" )
		if [ "$2" = "node_modules" ]; then
			return 1
		fi
		return 0
		;;
	"install" )
		npm install
		;;
	"clean" )
		if [ -d "node_modules" ]; then
			echo "Removing node_modules"
			rm -frv "node_modules"
		fi
		;;
esac

return 0
