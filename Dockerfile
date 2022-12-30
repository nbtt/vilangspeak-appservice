# Base image
FROM node:18

# Create app directory
WORKDIR /usr/src/app

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./
COPY yarn.lock ./

# Install app dependencies
RUN yarn install --frozen-lockfile

# Bundle app source
COPY --chown=node:node . .

# Creates a "dist" folder with the production build
RUN yarn build

USER node

# Start the server using the production build
CMD [ "node", "dist/main.js" ]