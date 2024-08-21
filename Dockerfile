FROM ruby:3.3

# Install required dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    nodejs \
    npm

# Set the working directory in the container
WORKDIR /workspace

# Copy Gemfile and Gemfile.lock for Ruby gems installation
COPY Gemfile ./
COPY Gemfile.lock ./

COPY package.json ./

# Copy the rest of the application code
COPY . .

# Install Ruby gems and cache them
RUN gem install bundler && bundle install

# Expose the port Bridgetown will run on
EXPOSE 4000