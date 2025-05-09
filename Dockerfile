FROM ruby:3.3

# Install required dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    libvips-dev \
    nodejs \
    npm

# Set environment variables for gems
ENV BUNDLE_PATH=/usr/local/bundle

# Set the working directory in the container
WORKDIR /workspace

# Copy Gemfile and Gemfile.lock for Ruby gems installation
COPY Gemfile ./
COPY Gemfile.lock ./
RUN gem install bundler foreman && bundle install

# Copy package.json for npm install
COPY package.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port Bridgetown will run on
EXPOSE 4000