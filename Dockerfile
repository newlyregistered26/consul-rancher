FROM gliderlabs/consul-server:0.6

ENTRYPOINT ["/consul_startup.sh"]

VOLUME ["/data"]

RUN apk --update add curl ca-certificates && \
    curl -Ls -o /bin/giddyup https://github.com/cloudnautique/giddyup/releases/download/v0.7.0/giddyup && \
    rm -rf /var/cache/apk/*

RUN curl -o ui.zip https://releases.hashicorp.com/consul/0.7.1/consul_0.7.1_web_ui.zip && \
    mkdir ui && \
    unzip -d ui ui.zip && \
    rm ui.zip
	
RUN curl -o /tmp/consul.zip https://releases.hashicorp.com/consul/0.7.1/consul_0.7.1_linux_amd64.zip && \
	cd /bin && \
	rm /bin/consul && unzip /tmp/consul.zip && chmod +x /bin/consul && rm /tmp/consul.zip

ADD files/consul_startup.sh /consul_startup.sh

RUN chmod +x /consul_startup.sh /bin/giddyup
