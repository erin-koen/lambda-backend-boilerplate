# Use the alpine build for whatever the lastest patch of Node 10.15 
FROM keymetrics/pm2:10-alpine

# install the PM2 runtime globally
RUN npm install pm2 -g

# make the node_modules & app directories in the /home/node subdirectory
# ensure they have the proper permissions so that we can avoid running the
# app as Root
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

# Set the working directory to the /app directory owned by the `node` user
WORKDIR /home/node/app

# Copy the package.json and package-lock.json files over to the WORKDIR
COPY package*.json ./

# Ensure that the application files are owned by the non-root user
# by switching to that user before installing packages
USER node

# Install all packages
RUN npm install

# Ensure copied application files are owned by the non-root user
COPY --chown=node:node . .

# Expose port 8080 to the outside world
EXPOSE 8080

# Execute the command needed to run the project
CMD [ "pm2-runtime", "app.js" ]