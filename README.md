# clamav-unofficial-atomicorp
Slightly enhanced default clamav docker image with [clamav-unofficial-sigs](https://github.com/extremeshok/clamav-unofficial-sigs/) and and updater for the signatures by [atomicorp](https://atomicorp.com).

## Tags
* latest ([Dockerfile](https://github.com/stimpy23/clamav-unofficial-atomicorp-docker))


## Environment Variables
### Enable / disable services
* `ADDITIONAL_ENABLED` (default: no [yes|no])

    Enable download of additional signatures.

* `INTERSERVER_ENABLED` (default: yes [yes|no])

    Enable signature download from [Interserver](http://sigs.interserver.net/)
	 
* `LINUXMALWAREDETECT_ENABLED` (default: yes [yes|no])

    Enable signature download from [LinuxMalwareDetect](https://www.rfxn.com/projects/linux-malware-detect/)
	 
* `MALWAREEXPERT_ENABLED` (default: yes [yes|no])

    Enable signature download from [MalwareExpert](https://malware.expert/signatures/)
	 
* `MALWAREPATROL_ENABLED` (default: yes [yes|no])

    Enable signature download from [MalwarePatrol](https://www.malwarepatrol.net/)
	 
* `SANESECURITY_ENABLED` (default: yes [yes|no])

    Enable signature download from [SaneSecurity](https://sanesecurity.com/)
	 
* `SECURITEINFO_ENABLED` (default: yes [yes|no])

    Enable signature download from [SecuriteInfo](https://www.securiteinfo.com/services-cybersecurite/anti-spam-anti-virus/improve-detection-rate-of-zero-day-malwares-for-clamav.shtml)
	 
* `URLHAUS_ENABLED` (default: yes [yes|no])

    Enable signature download from [URLHaus](https://urlhaus.abuse.ch/browse/)
	 
* `YARARULESPROJECT_ENABLED` (default: yes [yes|no])

    Enable signature download from [YaraRulesProject](https://yara-rules.github.io/blog/)

* `ENABLE_YARARULES` (default: no [yes|no])

    Enable yara rules in general (not only from YaraRulesProject)
		
### Atomicorp configuration
* `ATOMICORP_USER` (default: "")

    Your atomicorp subscription username (leave empty to disable)

* `ATOMICORP_PASS` (default: "")

    Your atomicorp subscription password

### Additional DBs configuration
* `ADDITIONAL_DBS` (default: "")

    Semicolon separated list of direct http(s)/rsync/file links for additional signatures
		
    e.g: `http://example.com/custom.cvd;https://example.com/more.cvd`

### MalwarePatrol configuration
* `MALWAREPATROL_RECEIPT_CODE` (default: "")

    Receipt code of your MalwarePatrol subscription.
		
* `MALWAREPATROL_PRODUCT_CODE` (default: "")

    Product code of your MalwarePatrol subscription.
		
* `MALWAREPATROL_LIST` (default: "" [clamav_basic|clamav_ext])

    Which list to download.
		
* `MALWAREPATROL_FREE` (default: "yes" [yes|no])

    Set to "no" to enable paid subscription.

* `MALWAREPATROL_DB` (default: malwarepatrol.db)

### MalwareExpert configuration
* `MALWAREEXPERT_SERIAL_KEY` (default: "")

    Authorisation signature of your MalwareExpert subscription.

### SecuriteInfo configuration
* `SECURITEINFO_AUTHORISATION_SIGNATURE` (default: "")

    Authorisation signature of your SecuriteInfo subscription.

* `SECURITEINFO_PREMIUM` (default: "no" [yes|no]

    Enable SecuriteInfo premium subscription.

### Signature update intervals.
Since the database files are dynamically created, non default values can cause banning, change with caution!

e.g: 4 = Update every 4 hours / 6 times a day)

* `ADDITIONAL_UPDATE_HOURS` (default: 4 [1..24])
* `INTERSERVER_UPDATE_HOURS` (default: 1 [1..24])
* `LINUXMALWAREDETECT_UPDATE_HOURS` (default: 5 [1..24])
* `MALWAREEXPERT_UPDATE_HOURS` (default: 2 [1..24])
* `MALWAREPATROL_UPDATE_HOURS` (default: 24 [1..24])
* `SANESECURITY_UPDATE_HOURS` (default: 1 [1..24])
* `SECURITEINFO_PREMIUM_UPDATE_HOURS` (default: 1 [1..24])
* `SECURITEINFO_UPDATE_HOURS` (default: 4 [1..24])
* `URLHAUS_UPDATE_HOURS` (default: 1 [1..24])
* `YARARULESPROJECT_UPDATE_HOURS` (default: 24 [1..24])

### Signature ratings.
REQUIRED | LOW | MEDIUM | HIGH | LOWONLY | MEDIUMONLY | LOWMEDIUMONLY | DISABLED

For details, please see [master.conf](https://github.com/extremeshok/clamav-unofficial-sigs/blob/master/config/master.conf) from clamav-unofficial-sigs

#### Parameters:
* `DEFAULT_DBS_RATING` (default: MEDIUM)

    Default rating for unconfigured databases
		
* `INTERSERVER_DBS_RATING` (default: "")
* `LINUXMALWAREDETECT_DBS_RATING` (default: "")
* `MALWAREEXPERT_DBS_RATING` (default: "")
* `SANESECURITY_DBS_RATING` (default: "")
* `SECURITEINFO_DBS_RATING` (default: "")
* `URLHAUS_DBS_RATING` (default: "")
* `YARARULESPROJECT_DBS_RATING` (default: "")

### General configuration
* `DOWNLOADER_IGNORE_SSL_ERRORS` (default: "no" [yes|no])

    Ignore SSL errors when downloading
		
* `CURL_PROXY` (default: "")

    Define a proxy for curl downloads if necessary.

* `DIG_PROXY` (default: "")

    Define a proxy for the dig command if necessary.

* `HOST_PROXY` (default: "")

    Define a proxy for the host command if necessary.

* `WGET_PROXY` (default: "")

    Define a proxy for wget downloads if necessary.

* `RSYNC_PROXY` (default: "")

    Define a proxy for rsync downloads if necessary.

* `RSYNC_CONNECT_PROG` (default: "")

    Define rsync to use netcat for socks tunnel:
		
	`nc -X 5 -x socksproxy_host:socksproxy_port %H 873`

* `FRESHCLAM_CHECKS` (default: 1 [1..24])

    How often freshclam should check for updates per day.
		
    12 times a day = once, every 2 hours.
    
## Exposed ports
* 3310 (clamd)
* 7357 (milter)

## Volumes
* `/var/lib/clamav`
    
    clamav signatures

* `/run/clamav`
    
    clamav.sock resides here

## Configuration
```
docker run -i -t -d \
    --name "clamav" \
    -v clamav_db:/var/lib/clamav \
    --mount type=bind,source=/run/clamav,target=/run/clamav \
    clamav-unofficial-atomicorp:latest
```
Give it a minute after (re-)configuration to run all updates and start clamd.

## Use via tcp
Install `clamdscan` and edit or create a configuration file at `/etc/clamav/clamd.conf`:
```
TCPSocket 3310
TCPAddr <ip address of your clamav container>
```

## Use via socket
You can also use clamav via its socket file by bind-mounting its folder to other containers:

    --mount type=bind,source=/run/clamav,target=/run/clamav

Then, you'll either have to use the `--stream` option with clamdscan or mount the target folder(s), you'ld like to scan, to both the the clamav- and the client container.

## Third Party Software
This docker image uses a lot of different software:

* [Alpine Linux](https://alpinelinux.org/)
* [Docker](https://docker.io)
* [ClamAV](https://clamav.net)
* [clamav-unofficial-sigs](https://github.com/extremeshok/clamav-unofficial-sigs)
