FROM alpine:latest AS builder
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles

RUN apk add --no-cache python3 py3-pip git libxml2-dev libxslt-dev build-base python3-dev

RUN python3 -m venv /opt/dosage-venv
ENV PATH="/opt/dosage-venv/bin:$PATH"

RUN pip install --no-cache-dir "dosage @ git+https://github.com/webcomics/dosage.git"

FROM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles

ENV RUNEVERY 7200
RUN apk add --no-cache libxslt libxml2 python3

COPY --from=builder /opt/dosage-venv /opt/dosage-venv
ENV PATH="/opt/dosage-venv/bin:$PATH"

RUN mkdir /dosage
WORKDIR /dosage

CMD dosage $OPTIONS -c @ ; while true; do rm -f /var/www/Comics/dailydose.rss; dosage $OPTIONS -c @; echo "Waiting $RUNEVERY seconds before next run of dosage"; sleep $RUNEVERY; done
