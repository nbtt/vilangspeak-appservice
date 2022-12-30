# Base image
FROM node:18

# Bundle app source
COPY --chown=node:node ./ /usr/src/app

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
RUN yarn install --frozen-lockfile

# Creates a "dist" folder with the production build
RUN yarn build

USER node

# Start the server using the production build
CMD [ "yarn", "start:prod" ]
