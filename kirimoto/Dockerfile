FROM node:18-slim
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles
RUN apt-get update && apt-get install -y --no-install-recommends git curl && rm -rf /var/lib/apt/lists/*
RUN git clone --depth=1 https://github.com/GridSpace/grid-apps.git /grid
WORKDIR /grid
EXPOSE 8080
RUN npm i && npm install -g @gridspace/app-server && npm cache clean --force
RUN rm -rf /grid/bin
CMD gs-app-server
