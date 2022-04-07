FROM debian:11-slim

ENV CONFIG_PREWIPE false
ENV EC2 false
ENV SOFTTIMER_TIMERFD true
ENV DEFAULT_PASSWORD 1234
ENV DEBIAN_FRONTEND noninteractive


# make the "en_US.UTF-8" locale so freeswitch will be utf-8 enabled by default
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8


RUN apt-get update && apt-get install -y gnupg2 wget lsb-release


RUN wget --http-user=signalwire --http-password=pat_BPJc9rkyjoPBavPay8tzhsHg -O /usr/share/keyrings/signalwire-freeswitch-repo.gpg https://freeswitch.signalwire.com/repo/deb/debian-release/signalwire-freeswitch-repo.gpg

RUN echo "machine freeswitch.signalwire.com login signalwire password pat_BPJc9rkyjoPBavPay8tzhsHg" > /etc/apt/auth.conf
RUN echo "deb [signed-by=/usr/share/keyrings/signalwire-freeswitch-repo.gpg] https://freeswitch.signalwire.com/repo/deb/debian-release/ `lsb_release -sc` main" > /etc/apt/sources.list.d/freeswitch.list
RUN echo "deb-src [signed-by=/usr/share/keyrings/signalwire-freeswitch-repo.gpg] https://freeswitch.signalwire.com/repo/deb/debian-release/ `lsb_release -sc` main" >> /etc/apt/sources.list.d/freeswitch.list

RUN apt-get update && apt-get install -y freeswitch-meta-all \
      && apt-get -y install libfreeswitch-dev libtool libesl-perl \
      && apt-get clean && rm -rf /var/lib/apt/lists/*

# Clean up
RUN apt-get autoremove

# Volumes
## Freeswitch Configuration
VOLUME ["/etc/freeswitch"]
## Tmp so we can get core dumps out
VOLUME ["/tmp"]

## Ports
# Open the container up to the world.
### 8021 fs_cli, 5060 5061 5080 5081 sip and sips, 64535-65535 rtp
EXPOSE 5060/tcp 5060/udp 5080/tcp 5080/udp
EXPOSE 5061/tcp 5061/udp 5081/tcp 5081/udp
EXPOSE 5066/tcp 7443/tcp
EXPOSE 5070/udp 5070/tcp
EXPOSE 8021/tcp
## RTP ports
#EXPOSE 64535-65535/udp
#EXPOSE 16384-32768/udp

# Limits Configuration
COPY freeswitch.limits.conf /etc/security/limits.d/

COPY reload.sh /opt/local/bin/reload.sh
COPY dialer.pl /opt/local/bin/dialer.pl

# Healthcheck to make sure the service is running
SHELL       ["/bin/bash"]
HEALTHCHECK --interval=15s --timeout=5s \
    CMD  fs_cli -x status | grep -q ^UP || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["freeswitch"]