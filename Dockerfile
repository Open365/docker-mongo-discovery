FROM mongo:2.6
MAINTAINER eyeos

ENV WHATAMI mongo

COPY start.sh /tmp/start.sh

RUN \
	apt-get update && \
	apt-get install -y curl && \
	curl -sL https://deb.nodesource.com/setup | bash - && \
	apt-get install -y unzip nodejs npm git build-essential && \
	npm config set registry http://artifacts.eyeosbcn.com/nexus/content/groups/npm/ && \
	chmod +x /tmp/start.sh && \
	curl -L https://releases.hashicorp.com/serf/0.6.4/serf_0.6.4_linux_amd64.zip -o serf.zip && \
	unzip serf.zip && \
	mv serf /usr/bin/serf && \
	npm install -g npm && \
	npm install -g eyeos-run-server eyeos-tags-to-dns eyeos-service-ready-notify-cli && \
	apt-get clean && \
	apt-get -y remove --purge curl git build-essential && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

CMD /tmp/start.sh

EXPOSE 27017
