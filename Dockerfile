FROM ruby:2.7
LABEL maintainer="Kyle-Law" 
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \ 
nodejs
COPY ./Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn
RUN yarn install --check-files
RUN bundle install
COPY . /usr/src/app/ 
RUN rails webpacker:install
CMD ["bin/rails","s","-b","0.0.0.0"]