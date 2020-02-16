#!/usr/bin/env bash

if [ -x /usr/bin/ssh ]; then
	export GIT_SSH=/usr/bin/ssh

	# Does not works if -e is specified
	export RSYNC_RSH=/usr/bin/ssh
fi

# For pip (python) local install
if [ -x /home/jehon/.local/bin ]; then
	export PATH="/home/jehon/.local/bin/:$PATH"
fi

if [ -x /home/jehon/Documents/src/packages/bin/ ]; then
	export PATH="/home/jehon/Documents/src/packages/bin/:$PATH"
	export PATH="/home/jehon/Documents/src/packages/jehon-base-minimal/usr/bin/:$PATH"
fi

if [ -x /home/jehon/Documents/src/bin ]; then
	export PATH="/home/jehon/Documents/src/bin/:$PATH"
fi

if [ -d ~/Documents/src ]; then
	while read F ; do
		echo "Importing $F"
		. "$F"
	done < <( find ~/Documents/src -name "custom-bash*" )
fi
