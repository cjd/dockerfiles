FROM alpine:latest

ENV RUNEVERY 7200
ENV HOME /
RUN apk add libxslt libxml2 && \
    apk add python3 py3-pip git libxml2-dev libxslt-dev build-base python3-dev && \
    pip3 install pipx && \
    pipx install "dosage @ git+https://github.com/webcomics/dosage.git" && \
    apk del git libxml2-dev libxslt-dev build-base python3-dev && \
    mkdir /dosage
WORKDIR /dosage

CMD /.local/bin/dosage $OPTIONS -c @ ; while true; do rm /var/www/Comics/dailydose.rss; /.local/bin/dosage $OPTIONS -c @; echo "Waiting $RUNEVERY seconds before next run of dosage"; sleep $RUNEVERY; done


