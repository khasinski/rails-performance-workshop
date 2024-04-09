# Make sure it matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.3.0
FROM ruby:$RUBY_VERSION-alpine

# Install libvips for Active Storage preview support
RUN apk add --no-cache --update nodejs npm build-base vips-dev libpq postgresql-dev gcompat tzdata

# Rails app lives here
#WORKDIR /app

# Set production environment
ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true" \
    RAILS_ENV="production" \
    BUNDLE_WITHOUT="development" \
    SECRET_KEY_BASE="1"

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . /app

RUN mkdir -p /rails/log

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN bundle exec rails assets:precompile

WORKDIR /app

# Start the server by default, this can be overwritten at runtime
EXPOSE 3001
CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "3001"]
