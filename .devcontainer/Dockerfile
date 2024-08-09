# Use the official Ruby image from the Docker Hub
FROM ruby:3.2

# Install required dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    nodejs \
    npm

# Install Yarn
RUN npm install -g yarn

# Set the working directory in the container
WORKDIR /workspace

# Install Bridgetown and other necessary gems
RUN gem install bridgetown
RUN yarn install

# Expose the port Bridgetown will run on
EXPOSE 4000
