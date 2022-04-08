FROM alpine:latest as build

LABEL maintainer="Ricardo Deizeppe <ricardo.deizeppe@gmail.com>"

ENV ENV="/etc/profile"
ENV WORKDIR /app
WORKDIR ${WORKDIR}

USER root

RUN apk add --update --no-cache \
      freeswitch \
      freeswitch-flite \
      freeswitch-sounds-en-us-callie-8000 \
      freeswitch-sounds-pt-br-karina-8000 \
      freeswitch-sounds-music-8000 \
      freeswitch-sample-config \
      freeswitch-perl \
      freeswitch-python3\
      freeswitch-timezones \
      freeswitch-perlesl \
      vim \
      perl \
      libtool \
      git \
 && rm -rf /var/cache/apk/* \
           /tmp/* \
           /var/tmp/*

RUN chown -R freeswitch:freeswitch /etc/freeswitch
USER freeswitch

EXPOSE 5060/tcp 5060/udp 5080/tcp 5080/udp
EXPOSE 5066/tcp 7443/tcp
EXPOSE 8021/tcp
EXPOSE 64535-65535/udp

COPY build/dialer.pl /opt/local/bin/dialer.pl
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/freeswitch", "-u", "freeswitch", "-g", "freeswitch"]