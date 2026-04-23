FROM python:3.8
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles
RUN apt-get update && apt-get install -y --no-install-recommends libffi-dev libssl-dev && rm -rf /var/lib/apt/lists/*
RUN pip3 install python-miio

CMD [ "/usr/local/bin/miiocli", "" ]
