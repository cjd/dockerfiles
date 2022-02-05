FROM alpine:latest

ENV LANG C.UTF-8

RUN apk add python3 curl py3-paho-mqtt
# Install latest pip
#RUN python3 -m ensurepip && \
#    pip3 install --no-cache --upgrade pip

# Install rtl_433 mqtt bridge prereq
#RUN pip3 install --no-cache paho-mqtt

# Clone rtl_433 repo and copy the latest tested version of the mqtt bridge script
# (latest as of 12/25/2020)
RUN curl -L https://raw.githubusercontent.com/merbanan/rtl_433/master/examples/rtl_433_mqtt_hass.py | grep -v "device_class\": \"weath" > /rtl_433_mqtt_hass.py && \
  chmod +x /rtl_433_mqtt_hass.py

ENTRYPOINT [ "python3", "/rtl_433_mqtt_hass.py", "-d", "-u", "ha", "-P", "ha", "-H", "192.168.0.10", "-p", "1883", "-D", "homeassistant", "-i", "300", "-r" ]
