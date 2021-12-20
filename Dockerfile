FROM clamav/clamav:latest

LABEL maintainer="Philipp Giebel <public@ambnet.biz>"

ENV MALWAREPATROL_RECEIPT_CODE=""
ENV MALWAREPATROL_PRODUCT_CODE=""
ENV MALWAREPATROL_LIST=""
ENV MALWAREPATROL_FREE=""
ENV MALWAREPATROL_DB=""
ENV MALWAREEXPERT_SERIAL_KEY=""
ENV SECURITEINFO_AUTHORISATION_SIGNATURE=""
ENV SECURITEINFO_PREMIUM=""
ENV ADDITIONAL_UPDATE_HOURS=""
ENV INTERSERVER_UPDATE_HOURS=""
ENV LINUXMALWAREDETECT_UPDATE_HOURS=""
ENV MALWAREEXPERT_UPDATE_HOURS=""
ENV MALWAREPATROL_UPDATE_HOURS=""
ENV SANESECURITY_UPDATE_HOURS=""
ENV SECURITEINFO_PREMIUM_UPDATE_HOURS=""
ENV SECURITEINFO_UPDATE_HOURS=""
ENV URLHAUS_UPDATE_HOURS=""
ENV YARARULESPROJECT_UPDATE_HOURS=""
ENV ADDITIONAL_ENABLED=""
ENV INTERSERVER_ENABLED=""
ENV LINUXMALWAREDETECT_ENABLED=""
ENV MALWAREEXPERT_ENABLED=""
ENV MALWAREPATROL_ENABLED=""
ENV SANESECURITY_ENABLED=""
ENV SECURITEINFO_ENABLED=""
ENV URLHAUS_ENABLED=""
ENV YARARULESPROJECT_ENABLED=""
ENV ENABLE_YARARULES=""
ENV DEFAULT_DBS_RATING=""
ENV INTERSERVER_DBS_RATING=""
ENV LINUXMALWAREDETECT_DBS_RATING=""
ENV MALWAREEXPERT_DBS_RATING=""
ENV SANESECURITY_DBS_RATING=""
ENV SECURITEINFO_DBS_RATING=""
ENV URLHAUS_DBS_RATING=""
ENV YARARULESPROJECT_DBS_RATING=""
ENV ADDITIONAL_DBS=""
ENV CLAMD_RESTART_OPT=""
ENV DOWNLOADER_IGNORE_SSL_ERRORS=""
ENV CURL_PROXY=""
ENV DIG_PROXY=""
ENV HOST_PROXY=""
ENV RSYNC_PROXY=""
ENV RSYNC_CONNECT_PROG=""
ENV WGET_PROXY=""
ENV ATOMICORP_USER=""
ENV ATOMICORP_PASS=""
ENV FRESHCLAM_CHECKS=""

RUN apk add --no-cache \
    rsync \
    bash \
    bind-tools \
    patch \
    wget \
    ncurses

# Download and install clamav-unofficial-sigs downloader
RUN mkdir -p /usr/local/sbin \
    && mkdir -p /etc/clamav-unofficial-sigs/ \
    && wget --quiet https://raw.githubusercontent.com/extremeshok/clamav-unofficial-sigs/master/clamav-unofficial-sigs.sh -O /usr/local/sbin/clamav-unofficial-sigs.sh \
    && chmod 755 /usr/local/sbin/clamav-unofficial-sigs.sh \
    && wget --quiet https://raw.githubusercontent.com/extremeshok/clamav-unofficial-sigs/master/config/master.conf -O /etc/clamav-unofficial-sigs/master.conf \
    && wget --quiet https://raw.githubusercontent.com/extremeshok/clamav-unofficial-sigs/master/config/user.conf -O /etc/clamav-unofficial-sigs/user.conf \
    && wget --quiet "https://raw.githubusercontent.com/extremeshok/clamav-unofficial-sigs/master/config/os/os.alpine.conf" -O /etc/clamav-unofficial-sigs/os.conf \
    && sed -i 's/work_dir_urlhaust/work_dir_urlhaus/g' /usr/local/sbin/clamav-unofficial-sigs.sh 

# Add update-other-rules.sh to freshclam configuration
RUN echo "OnUpdateExecute /usr/local/sbin/update-other-rules.sh" >>/etc/clamav/freshclam.conf

# Add clamav-unofficial-sigs autoconfiguration to existing init script
COPY /docker-entrypoint.patch .
RUN /usr/bin/patch init docker-entrypoint.patch \
    && rm -f docker-entrypoint.patch

# Add dbs-uh directory since clamav-unofficial-sigs isnt..
RUN mkdir -p /var/lib/clamav-unofficial-sigs/dbs-uh \
    && chown clamav:clamav /var/lib/clamav-unofficial-sigs/dbs-uh

# Add update-other-rules.sh
COPY /update-other-rules.sh /usr/local/sbin/
RUN chown root:clamav /usr/local/sbin/update-other-rules.sh \
    && chmod 750 /usr/local/sbin/update-other-rules.sh

# Disable clamd and freshclam logging
RUN sed -i 's/^LogFile .*/LogFile \/dev\/stdout/g' /etc/clamav/clamd.conf \
    && sed -i 's/^UpdateLogFile \(.*\)/#UpdateLogFile \1/g' /etc/clamav/freshclam.conf \
    && rm -rf /var/log/clamav

# Fix clamdcheck.sh
RUN sed -i 's/localhost/127.0.0.1/g' /usr/local/bin/clamdcheck.sh

# Fix /var/run permissions and ownership
RUN chown root:clamav /run/clamav \
    && chmod 775 /run/clamav

EXPOSE 3310
EXPOSE 7357

VOLUME /var/lib/clamav
VOLUME /run/clamav

HEALTHCHECK CMD "clamdcheck.sh"

ENTRYPOINT [ "/init" ]
