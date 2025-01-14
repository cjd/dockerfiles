FROM python:3.8
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles
RUN apt-get install  libffi-dev libssl-dev
RUN pip3 install python-miio

CMD [ "/usr/local/bin/miiocli", "" ]
