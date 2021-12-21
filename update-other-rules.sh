#!/bin/bash

set +eu

# remove stale semaphore
rm -f /tmp/reload

# Write clamav-unofficial-sigs configuration according to
# Docker environment variables
echo "# clamav-unofficial-sigs configuration created by docker container" >/etc/clamav-unofficial-sigs/user.conf.new
echo "# DO NOT EDIT! This will be overwritten on startup. Use environment variables instead." >>/etc/clamav-unofficial-sigs/user.conf.new
echo "" >>/etc/clamav-unofficial-sigs/user.conf.new

if [ -n "${MALWAREPATROL_RECEIPT_CODE}" ]; then
    echo "malwarepatrol_receipt_code=\"${MALWAREPATROL_RECEIPT_CODE}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${MALWAREPATROL_PRODUCT_CODE}" ]; then
    echo "malwarepatrol_product_code=\"${MALWAREPATROL_PRODUCT_CODE}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${MALWAREPATROL_LIST}" ]; then
    echo "malwarepatrol_list=\"${MALWAREPATROL_LIST}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${MALWAREPATROL_FREE}" ]; then
    echo "malwarepatrol_free=\"${MALWAREPATROL_FREE}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${MALWAREPATROL_DB}" ]; then
    echo "malwarepatrol_db=\"${MALWAREPATROL_DB}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${MALWAREEXPERT_SERIAL_KEY}" ]; then
    echo "malwareexpert_serial_key=\"${MALWAREEXPERT_SERIAL_KEY}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${SECURITEINFO_AUTHORISATION_SIGNATURE}" ]; then
    echo "securiteinfo_authorisation_signature=\"${SECURITEINFO_AUTHORISATION_SIGNATURE}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${SECURITEINFO_PREMIUM}" ]; then
    echo "securiteinfo_premium=\"${SECURITEINFO_PREMIUM}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${ADDITIONAL_UPDATE_HOURS}" ]; then
    echo "additional_update_hours=\"${ADDITIONAL_UPDATE_HOURS}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${INTERSERVER_UPDATE_HOURS}" ]; then
    echo "interserver_update_hours=\"${INTERSERVER_UPDATE_HOURS}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${LINUXMALWAREDETECT_UPDATE_HOURS}" ]; then
    echo "linuxmalwaredetect_update_hours=\"${LINUXMALWAREDETECT_UPDATE_HOURS}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${MALWAREEXPERT_UPDATE_HOURS}" ]; then
    echo "malwareexpert_update_hours=\"${MALWAREEXPERT_UPDATE_HOURS}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${MALWAREPATROL_UPDATE_HOURS}" ]; then
    echo "malwarepatrol_update_hours=\"${MALWAREPATROL_UPDATE_HOURS}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${SANESECURITY_UPDATE_HOURS}" ]; then
    echo "sanesecurity_update_hours=\"${SANESECURITY_UPDATE_HOURS}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${SECURITEINFO_PREMIUM_UPDATE_HOURS}" ]; then
    echo "securiteinfo_premium_update_hours=\"${SECURITEINFO_PREMIUM_UPDATE_HOURS}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${SECURITEINFO_UPDATE_HOURS}" ]; then
    echo "securiteinfo_update_hours=\"${SECURITEINFO_UPDATE_HOURS}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${URLHAUS_UPDATE_HOURS}" ]; then
    echo "urlhaus_update_hours=\"${URLHAUS_UPDATE_HOURS}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${YARARULESPROJECT_UPDATE_HOURS}" ]; then
    echo "yararulesproject_update_hours=\"${YARARULESPROJECT_UPDATE_HOURS}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${ADDITIONAL_ENABLED}" ]; then
    echo "additional_enabled=\"${ADDITIONAL_ENABLED}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${INTERSERVER_ENABLED}" ]; then
    echo "interserver_enabled=\"${INTERSERVER_ENABLED}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${LINUXMALWAREDETECT_ENABLED}" ]; then
    echo "linuxmalwaredetect_enabled=\"${LINUXMALWAREDETECT_ENABLED}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${MALWAREEXPERT_ENABLED}" ]; then
    echo "malwareexpert_enabled=\"${MALWAREEXPERT_ENABLED}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${MALWAREPATROL_ENABLED}" ]; then
    echo "malwarepatrol_enabled=\"${MALWAREPATROL_ENABLED}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${SANESECURITY_ENABLED}" ]; then
    echo "sanesecurity_enabled=\"${SANESECURITY_ENABLED}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${SECURITEINFO_ENABLED}" ]; then
    echo "securiteinfo_enabled=\"${SECURITEINFO_ENABLED}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${URLHAUS_ENABLED}" ]; then
    echo "urlhaus_enabled=\"${URLHAUS_ENABLED}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${YARARULESPROJECT_ENABLED}" ]; then
    echo "yararulesproject_enabled=\"${YARARULESPROJECT_ENABLED}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${ENABLE_YARARULES}" ]; then
    echo "enable_yararules=\"${ENABLE_YARARULES}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${DEFAULT_DBS_RATING}" ]; then
    echo "default_dbs_rating=\"${DEFAULT_DBS_RATING}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${INTERSERVER_DBS_RATING}" ]; then
    echo "interserver_dbs_rating=\"${INTERSERVER_DBS_RATING}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${LINUXMALWAREDETECT_DBS_RATING}" ]; then
    echo "linuxmalwaredetect_dbs_rating=\"${LINUXMALWAREDETECT_DBS_RATING}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${MALWAREEXPERT_DBS_RATING}" ]; then
    echo "malwareexpert_dbs_rating=\"${MALWAREEXPERT_DBS_RATING}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${SANESECURITY_DBS_RATING}" ]; then
    echo "sanesecurity_dbs_rating=\"${SANESECURITY_DBS_RATING}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${SECURITEINFO_DBS_RATING}" ]; then
    echo "securiteinfo_dbs_rating=\"${SECURITEINFO_DBS_RATING}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${URLHAUS_DBS_RATING}" ]; then
    echo "urlhaus_dbs_rating=\"${URLHAUS_DBS_RATING}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${YARARULESPROJECT_DBS_RATING}" ]; then
    echo "yararulesproject_dbs_rating=\"${YARARULESPROJECT_DBS_RATING}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${ADDITIONAL_DBS}" ]; then
    echo "declare -a additional_dbs=(" >>/etc/clamav-unofficial-sigs/user.conf.new
    echo "${ADDITIONAL_DBS}" |sed 's/;/\n/g' >>/etc/clamav-unofficial-sigs/user.conf.new
    echo ")" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${CLAMD_RESTART_OPT}" ]; then
    echo "clamd_restart_opt=\"${CLAMD_RESTART_OPT}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${DOWNLOADER_IGNORE_SSL_ERRORS}" ]; then
    echo "downloader_ignore_ssl_errors=\"${DOWNLOADER_IGNORE_SSL_ERRORS}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${CURL_PROXY}" ]; then
    echo "curl_proxy=\"${CURL_PROXY}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${DIG_PROXY}" ]; then
    echo "dig_proxy=\"${DIG_PROXY}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${HOST_PROXY}" ]; then
    echo "host_proxy=\"${HOST_PROXY}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${RSYNC_PROXY}" ]; then
    echo "rsync_proxy=\"${RSYNC_PROXY}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${RSYNC_CONNECT_PROG}" ]; then
    echo "rsync_connect_prog=\"${RSYNC_CONNECT_PROG}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
if [ -n "${WGET_PROXY}" ]; then
    echo "wget_proxy=\"${WGET_PROXY}\"" >>/etc/clamav-unofficial-sigs/user.conf.new
fi
echo "clamd_reload_opt=\"/bin/touch /tmp/reload\"" >>/etc/clamav-unofficial-sigs/user.conf.new
echo "logging_enabled=\"no\"" >>/etc/clamav-unofficial-sigs/user.conf.new
echo "user_configuration_complete=\"yes\"" >>/etc/clamav-unofficial-sigs/user.conf.new

# Checking if configuration has changed
forced=0
/usr/bin/cmp -s /etc/clamav-unofficial-sigs/user.conf /etc/clamav-unofficial-sigs/user.conf.new
if [ $? -gt 0 ]; then
    echo "*** clamav-unofficial-sigs configuration changed. Forcing update. ***"
    mv /etc/clamav-unofficial-sigs/user.conf.new /etc/clamav-unofficial-sigs/user.conf
    /usr/local/sbin/clamav-unofficial-sigs.sh -F
    chown clamav:clamav /tmp/reload
    forced=1
else
    rm /etc/clamav-unofficial-sigs/user.conf.new
fi

# Check if updatecounter exists, create if not.
if [ ! -f /tmp/atomicorpupdater.tmp ]; then
    echo "0" >/tmp/atomicorpupdater.tmp
    chown clamav:clamav /tmp/atomicorpupdater.tmp
fi

counter=1
while [ 1=1 ]; do
    if [ $counter -eq 1 ]; then
        echo "*** Running atomicorp updater ***"
        /bin/su -s /bin/sh clamav -c '/usr/local/sbin/update-atomicorp-sigs.sh'
    fi

    if [ $forced -eq 0 ]; then
        echo "*** Running clamav-unofficial-sigs.sh ***"
        /bin/su -s /bin/sh clamav -c '/usr/local/sbin/clamav-unofficial-sigs.sh'
    fi

    if [ -e /tmp/reload ]; then
        echo "*** Reloading ClamD databases ***"
        /usr/bin/clamdscan --reload
        rm /tmp/reload
    fi
    counter=$((counter+1))
    if [ $counter -gt 4 ]; then
        counter=1
    fi
    forced=0
    sleep 3600
done
