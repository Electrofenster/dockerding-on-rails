FROM ruby:2.2.3
MAINTAINER Evolutio1994@gmx.de

# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  npm \
  git

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /app
WORKDIR /app

# linking nodejs to node
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Cloneing dockerding
RUN git clone https://github.com/Electrofenster/dockerding-on-rails /app/

# set ENV
ENV RAILS_ENV production
ENV SECRET_KEY_BASE eab5828da49b4013532041cca286972d7a003b87bfa658b54ad5f6d7bc85f4229b38febcf1cfa7378961c09a6c9e739f317a642f472c79b61301b6ca6d2c496c
ENV RAILS_SERVE_STATIC_FILES true

# Install bower
RUN npm install -g bower

# install bundler
RUN gem install bundler

# Install gems
RUN bundle --deployment --without development test cucumber

# Install Assets
RUN bundle exec rake bower:install['--allow-root']

# Assets precompilen
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# run the rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "puma", "-p", "3000"]
