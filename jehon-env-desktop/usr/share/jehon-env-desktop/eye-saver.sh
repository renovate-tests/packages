#!/usr/bin/env bash

RUND="/var/run/user/$(id -u)"
mkdir -p "$RUND"
PID_FILE="$RUND/eyseaver.pid" 
STATUS_FILE="$RUND/eyseaver.status"

minutes() {
    # echo "$1"
    echo $(( $1 * 60))
}

# Parameters
CHECK_TIME="$(minutes 1)"
VALID_SLEEP="$(minutes 3)"
WORK_PERIOD_STOP="$(minutes 45)"
# 5 minutes before...
WORK_PERIOD_WARNING="$(( $WORK_PERIOD_STOP - $(minutes 5) ))"

get_time() {
    date +%s
}
print_time() {
    date -d "@$1"
}

msg() {
    # shellcheck disable=SC1117
    zenity --info \
        --height=300 \
        --width=400 \
        --no-wrap \
        --title "Watch your eyes" \
        --text "$1\n\n(You are here since $( print_time "${BECOME_INACTIVE}" ) )" &
}

IDL=0
BECOME_INACTIVE=$( get_time )

if [ "$1" == "test" ]; then
    msg "Ouille, il faut se reposer... "
    exit 1
fi

# Save the pid
echo $$ > "$PID_FILE"
finish() {
  rm -f "$PID_FILE"
}
trap finish EXIT


# Check periodically
while true; do
    sleep "${CHECK_TIME}s"
	(
		echo "BECOME_INACTIVE=$BECOME_INACTIVE"
		echo "WORK_PERIOD_STOP=$WORK_PERIOD_STOP"
		echo "WORK_PERIOD_WARNING=$WORK_PERIOD_WARNING"
		echo "PID=$PID"
	) > $STATUS_FILE

    # In ms
    IDL="$(( $( xprintidle ) / 1000 ))"
    if [ "$IDL" -gt "$VALID_SLEEP" ]; then
        BECOME_INACTIVE=$( get_time )
    else
        if (( "${BECOME_INACTIVE}" + "${WORK_PERIOD_STOP}" < $(get_time) )); then
            msg "Désolé, trop de travail !"
            gnome-session-quit --no-prompt
        else
            if (( "${BECOME_INACTIVE}" + "${WORK_PERIOD_WARNING}" < $(get_time) )); then
                msg "Ouille, il faut se reposer... "
            fi
        fi
    fi
done
