FROM node:latest
LABEL org.opencontainers.image.source https://github.com/cjd/dockerfiles
RUN apt-get -y update && apt-get -y install git curl
RUN git clone --depth=1 https://github.com/viliusle/miniPaint
WORKDIR /miniPaint
EXPOSE 8080
RUN npm install
RUN sed --in-place -e "s/static:/allowedHosts: 'all',\nstatic:/g" /miniPaint/webpack.config.js
CMD ["npm", "run", "server"]
