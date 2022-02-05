FROM alpine:latest

ENV RUNEVERY 7200
WORKDIR /app
RUN apk add libxslt libxml2 && \
    apk add python3 py3-pip git libxml2-dev libxslt-dev build-base python3-dev && \
    git clone https://github.com/webcomics/dosage.git /app && \
    pip3 install --upgrade pip && \
    pip3 install -r requirements.txt && \
    python3 setup.py install && \
    apk del git libxml2-dev libxslt-dev build-base python3-dev && \
    mkdir /dosage
WORKDIR /dosage

CMD dosage $OPTIONS -c @ ; while true; do rm /var/www/Comics/dailydose.rss; dosage $OPTIONS -c @; echo "Waiting $RUNEVERY seconds before next run of dosage"; sleep $RUNEVERY; done


