# Base stage for building
FROM node:10-alpine AS base

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache make gcc g++ python python3 linux-headers udev git

# Clone the LaserWeb4 repository (using dev-es6 branch as per the source of Dockerfile.release)
RUN git clone https://github.com/LaserWeb/LaserWeb4.git . && \
    git checkout dev-es6

# Configure git to use https instead of ssh for submodules/dependencies if any
RUN git config --global url."https://github.com".insteadOf "ssh://git@github.com"

# Install dependencies
RUN npm set progress=false && npm config set depth 0
RUN npm ci

# ---- Release Stage ----
FROM node:10-alpine

ENV ENV="production"
ENV NODE_ENV="production"

# Install runtime dependencies
RUN apk add --no-cache udev

WORKDIR /app

# Copy built application from the base stage
COPY --from=base /app ./

# LaserWeb4 default port
EXPOSE 8000

# Start the server
CMD [ "npm", "run", "start-server" ]
