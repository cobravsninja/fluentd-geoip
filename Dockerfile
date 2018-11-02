FROM debian:9

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y curl libgeoip-dev build-essential automake autoconf libtool && \
    curl https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add - && \
    echo "deb http://packages.treasuredata.com/3/debian/stretch/ stretch contrib" > /etc/apt/sources.list.d/treasure-data.list && \
    apt-get update && \
    apt-get install -y td-agent && \
    /opt/td-agent/usr/sbin/td-agent-gem install fluent-plugin-geoip && \
    apt-get remove --purge -y build-essential automake autoconf libtool && \
    apt-get -y autoremove --purge && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/log/*
