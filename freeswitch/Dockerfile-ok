FROM debian:jessie

ENV CONFIG_PREWIPE false
ENV EC2 false
ENV SOFTTIMER_TIMERFD true
ENV DEFAULT_PASSWORD 1234
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install curl && \
      curl https://files.freeswitch.org/repo/deb/debian/freeswitch_archive_g0.pub | apt-key add - && \
      echo "deb http://files.freeswitch.org/repo/deb/freeswitch-1.6/ jessie main" > /etc/apt/sources.list.d/freeswitch.list && \
      apt-get -y update && apt-get -y upgrade && \
      apt-get -y install xmlstarlet git vim freeswitch-all freeswitch-all-dbg gdb && \
      rm -rf /var/lib/apt/lists/*

VOLUME /etc/freeswitch /var/lib/freeswitch /var/log/freeswitch /usr/share/freeswitch

EXPOSE 5060/tcp 5060/udp 5080/tcp 5080/udp
EXPOSE 5066/tcp 7443/tcp
EXPOSE 8021/tcp

COPY entry.sh /opt/local/bin/entry.sh
COPY reload.sh /opt/local/bin/reload.sh

ENTRYPOINT ["/opt/local/bin/entry.sh"]

CMD ["freeswitch", "-c", "-nf"]
