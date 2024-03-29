#!/usr/bin/env bash

set -e

#
# 1: key id
# 2: key name (free text)
# 3: [local file]
#

if [ -z "$1" ]; then
    echo "Please specify key id as [1]"  >&2
    false
fi
KEY_ID="$1"

if [ -z "$2" ]; then
    echo "Please specify key label (free text) as [2]" >&2
    false
fi
KEY_LABEL="$2"

KEY_FILE="$3"

if [ -r /etc/apt/trusted.gpg ]; then
    if gpg --keyring /etc/apt/trusted.gpg --no-default-keyring --list-key "$KEY_ID" >& /dev/null ; then
        echo "*** Key $KEY_LABEL ($KEY_ID): already found"
        exit 0
    fi
fi

echo "*** Key $KEY_LABEL ($KEY_ID): adding"
(
    export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
    if [ -f "$3" ]; then
        apt-key add "$KEY_FILE"
    else
        # curl -sL "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x$KEY_ID" | sudo apt-key add
        apt-key adv --recv-keys --keyserver keyserver.ubuntu.com "$KEY_ID"
    fi
) > /dev/null

exit 0
