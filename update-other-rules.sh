#!/bin/bash

# just a small change so docker will recognize this as newer
if [ -n "${ATOMICORP_USER}" ]; then
    if [ ! -f /tmp/atomicorpupdater.tmp ]; then
        echo "0" >/tmp/atomicorpupdater.tmp
    fi

    filename=$( /usr/bin/wget --quiet -O- "https://${ATOMICORP_USER}:${ATOMICORP_PASS}@updates.atomicorp.com/channels/rules/subscription/" |grep clamav |sed "s/.*href='\(.*\)' class.*/\1/" |grep -v asc |uniq |sort |tail -n1 )
    if [ $( grep -c "$filename" /tmp/atomicorpupdater.tmp ) -eq 0 ]; then
        echo "*** Updating Atomicorp Rules ***"
        echo -n "$filename" >/tmp/atomicorpupdater.tmp
        TMP=$(/bin/mktemp -d)
        /usr/bin/wget --quiet -O- "https://${ATOMICORP_USER}:${ATOMICORP_PASS}@updates.atomicorp.com/channels/rules/subscription/${filename}" |tar -jx -C ${TMP}/
        mv ${TMP}/clamav/* /var/lib/clamav/
        rm -rf ${TMP}
    fi
fi

echo "*** Running clamav-unofficial-sigs.sh ***"
/usr/local/sbin/clamav-unofficial-sigs.sh
/usr/bin/clamdscan --reload
