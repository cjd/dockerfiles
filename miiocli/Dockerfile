FROM python:3.8
#FROM python:3.7-alpine
RUN apt-get install  libffi-dev libssl-dev
#RUN apt add --no-cache  libffi-dev libssl-dev
RUN pip3 install python-miio

CMD [ "/usr/local/bin/miiocli", "" ]
