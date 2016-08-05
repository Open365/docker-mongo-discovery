FROM alpine:3.4
MAINTAINER eyeos

ENV WHATAMI mongo
ENV InstallationDir /var/service

WORKDIR ${InstallationDir}

COPY start.sh ${InstallationDir}/start.sh
COPY dnsmasq.conf /etc/dnsmasq.d/
COPY dnsmasq_generic.conf /etc/dnsmasq.conf

RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
	apk update && apk add curl git gcc g++ make python nodejs unzip dnsmasq mongodb && \
	chmod +x ${InstallationDir}/start.sh && \
	curl -L https://releases.hashicorp.com/serf/0.6.4/serf_0.6.4_linux_amd64.zip -o serf.zip && \
	unzip serf.zip && mv serf /usr/bin/serf && mkdir -p ${HOME} && \
	npm install -g node-gyp eyeos-run-server eyeos-tags-to-dns eyeos-service-ready-notify-cli && \
	npm cache clean && rm -rf $HOME/.npm && \
	apk del curl git gcc g++ make python unzip && rm -r /etc/ssl /var/cache/apk/* /tmp/*

CMD ["./start.sh"]

VOLUME /data/db

EXPOSE 27017
