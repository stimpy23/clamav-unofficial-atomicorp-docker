#!/bin/bash

set +eu

# Check if updatecounter exists, create if not.
if [ ! -f /tmp/atomicorpupdater.tmp ]; then
    echo "0" >/tmp/atomicorpupdater.tmp
fi

# Is the username set?
if [ -n "${ATOMICORP_USER}" ]; then

    # Check latest version online
    filename=$( /usr/bin/wget --quiet -O- "https://${ATOMICORP_USER}:${ATOMICORP_PASS}@updates.atomicorp.com/channels/rules/subscription/" | grep clamav |sed "s/.*href='\(.*\)' class.*/\1/" |grep -v asc |uniq |sort |tail -n1 )

    # Download if newer
    if [ $( grep -c "$filename" /tmp/atomicorpupdater.tmp ) -eq 0 ]; then
        echo "*** Updating Atomicorp Rules ***"
        echo -n "$filename" >/tmp/atomicorpupdater.tmp
        TMP=$(/bin/mktemp -d)
        /usr/bin/wget --quiet -O- "https://${ATOMICORP_USER}:${ATOMICORP_PASS}@updates.atomicorp.com/channels/rules/subscription/${filename}" | tar -jx -C ${TMP}/
        mv ${TMP}/clamav/* /var/lib/clamav/
        rm -rf ${TMP}
        touch /tmp/reload
    fi
    
fi
