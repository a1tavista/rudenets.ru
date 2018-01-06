FROM ruby:2.4-alpine

ENV PATH /root/.yarn/bin:$PATH

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh \
    build-base nodejs tzdata postgresql-dev python

RUN apk update \
  && apk add curl bash binutils tar gnupg \
  && rm -rf /var/cache/apk/* \
  && /bin/bash \
  && touch ~/.bashrc \
  && curl -o- -L https://yarnpkg.com/install.sh | bash \
  && apk del curl tar binutils

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install -j "$(getconf _NPROCESSORS_ONLN)" --retry 5 --without development test

COPY yarn.lock package.json ./
RUN yarn install --production=false

ENV NODE_ENV production
ENV RAILS_ENV production
ENV RACK_ENV production
ENV RAILS_ROOT /app

ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE $SECRET_KEY_BASE

ARG APPLICATION_HOST
ENV APPLICATION_HOST $APPLICATION_HOST

COPY . ./

RUN RAILS_ENV=production DATABASE_URL=postgresql:does_not_exist ./bin/rails assets:precompile

EXPOSE 3000
