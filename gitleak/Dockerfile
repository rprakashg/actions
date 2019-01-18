FROM alpine:latest 

LABEL MAINTAINER="Ram Gopinathan"

LABEL "com.github.actions.name"="Git Leak"
LABEL "com.github.actions.description"="Checks commit files when PR is submitted to see if secrets are checked in"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="red"

RUN	apk add --no-cache \
	bash \
	ca-certificates \
	curl \
	jq  

COPY gitleak.sh /usr/bin/gitleak.sh

ENTRYPOINT ["gitleak.sh"]

