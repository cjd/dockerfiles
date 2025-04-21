FROM node:18-slim
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles
RUN apt-get -y update && apt-get -y install git curl
RUN git clone --depth=1 https://github.com/GridSpace/grid-apps.git /grid
WORKDIR /grid
EXPOSE 8080
RUN npm i
RUN npm install -g @gridspace/app-server
RUN rm -rf /grid/bin
CMD gs-app-server
