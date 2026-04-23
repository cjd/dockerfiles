FROM alpine:latest AS builder
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles

RUN apk add --no-cache python3 py3-pip git libxml2-dev libxslt-dev build-base python3-dev
ENV HOME /
RUN pip3 install --no-cache-dir pipx && \
    pipx install "dosage @ git+https://github.com/webcomics/dosage.git"

FROM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles

ENV RUNEVERY 7200
ENV HOME /
RUN apk add --no-cache libxslt libxml2 python3
COPY --from=builder /.local /.local
RUN mkdir /dosage
WORKDIR /dosage

CMD /.local/bin/dosage $OPTIONS -c @ ; while true; do rm -f /var/www/Comics/dailydose.rss; /.local/bin/dosage $OPTIONS -c @; echo "Waiting $RUNEVERY seconds before next run of dosage"; sleep $RUNEVERY; done
