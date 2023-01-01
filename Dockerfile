# Base image
FROM node:18-alpine

# Bundle app source
COPY --chown=node:node ./ /usr/src/app
# Configuration
COPY --chown=node:node ./src/config/config.prod.yaml /usr/src/app/src/config/config.yaml

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
ENV YARN_CACHE_FOLDER=/root/.cache/yarn
RUN --mount=type=cache,target=/root/.cache/yarn yarn install

# Creates a "dist" folder with the production build
RUN yarn build

# Start the server using the production build
CMD [ "yarn", "start:prod" ]
