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

# Copy Gemfile and Gemfile.lock for Ruby gems installation
COPY Gemfile ./
COPY Gemfile.lock ./

# Copy package.json and yarn.lock for Yarn packages installation
COPY package.json ./
COPY yarn.lock ./

# Copy the rest of the application code
COPY . .

# Install Ruby gems and cache them
RUN gem install bundler && bundle install

# Install Yarn packages and cache them
RUN yarn install

# Expose the port Bridgetown will run on
EXPOSE 4000