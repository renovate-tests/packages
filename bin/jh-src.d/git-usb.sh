#!/usr/bin/env bash

git_usb_has_remote() {
	local REMOTE
	REMOTE=$(git remote)
	if [ "$REMOTE" = "" ]; then
		return 1
	fi
	return 0
}

SRC_PROJECT=$(basename "$(pwd)")
GIT_USB_STAGED="$SRC_PROJECT.1.staged.diff"
GIT_USB_UNSTAGED="$SRC_PROJECT.2.unstaged.diff"

case "$1" in
	"must_run" )
		if [ -r ".git" ] && git_usb_has_remote; then
			return 0
		fi
		return 1
		;;
	"finish" )
		# If the drive has been mounted, the unmount it...
		if [ -n "$GIT_USB_TARGET_DRIVE" ]; then
			drive "$GIT_USB_TARGET_DRIVE" -u
		fi
		;;
	"to-usb" )
		# Initialize it if it is empty
		if [ -z "$GIT_USB_TARGET_DRIVE" ]; then
			GIT_USB_TARGET_DRIVE="${2,,}"
			echo "Drive: $GIT_USB_TARGET_DRIVE"
			drive "$GIT_USB_TARGET_DRIVE" || exit 255
			GIT_USB_TARGET_DIR="/mnt/$GIT_USB_TARGET_DRIVE/swaps"
			if [ ! -d "$GIT_USB_TARGET_DIR" ]; then
				mkdir -p "$GIT_USB_TARGET_DIR"
			fi
		fi

		#git push --follow-tags || true
		#git push --tags || true
		git add -N .
		git diff --staged > "$GIT_USB_TARGET_DIR/$GIT_USB_STAGED"
		if [ ! -s "$GIT_USB_TARGET_DIR/$GIT_USB_STAGED" ]; then
			echo "No staged"
			rm "$GIT_USB_TARGET_DIR/$GIT_USB_STAGED"
		fi
		git diff > "$GIT_USB_TARGET_DIR/$GIT_USB_UNSTAGED"
		if [ ! -s "$GIT_USB_TARGET_DIR/$GIT_USB_UNSTAGED" ]; then
			echo "No unstaged"
			rm "$GIT_USB_TARGET_DIR/$GIT_USB_UNSTAGED"
		fi
		STATUS=$( jh-src.sh status | grep "##" ) 
		if [ "$STATUS" != "" ]; then
			echo "!!! Your local changes are not pushed upstrea !!!" >&2
			echo "$STATUS" >&2
		fi
		;;
	"from-usb" )
		# Initialize it if it is empty
		if [ -z "$GIT_USB_SOURCE" ]; then
			if [ ! -d "$2" ]; then
				echo "$2 is not a folder"
				exit 255
			fi
			GIT_USB_SOURCE="$2"
		fi

		git stash
		if [ -r "$GIT_USB_SOURCE/$GIT_USB_STAGED" ]; then
			(
				git apply --reject "$GIT_USB_SOURCE/$GIT_USB_STAGED" \
				&& git add . \
				&& mv -f "$GIT_USB_SOURCE/$GIT_USB_STAGED" "$GIT_USB_SOURCE/$GIT_USB_STAGED.bak" \
			) || true
		fi
		if [ -r "$GIT_USB_SOURCE/$GIT_USB_UNSTAGED" ]; then
			( 
				git apply --reject "$GIT_USB_SOURCE/$GIT_USB_UNSTAGED" \
				&& mv -f "$GIT_USB_SOURCE/$GIT_USB_UNSTAGED" "$GIT_USB_SOURCE/$GIT_USB_UNSTAGED.bak" \
			) || true
		fi
		git stash pop \
			|| echo "!!! Impossible to git stash pop. Manual operation needed."
		;;
esac

return 0
