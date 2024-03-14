# Make sure it matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.1.4
FROM ruby:$RUBY_VERSION

# Install libvips for Active Storage preview support
RUN apt-get update -qq && \
    apt-get install -y build-essential libvips nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

# Rails app lives here
WORKDIR /app

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

# Entrypoint prepares the database.
RUN chmod +x /app/bin/docker-entrypoint
ENTRYPOINT ["/app/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]
