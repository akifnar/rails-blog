# syntax=docker/dockerfile:1
ARG RUBY_VERSION=3.4.9
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 \
        libvips sqlite3 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle"



FROM base AS build


RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git \
        pkg-config libyaml-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY Gemfile Gemfile.lock ./
# PERFORMANS ARTIŞI: Paralel indirme ve Docker önbellek mekanizması eklendi
RUN --mount=type=cache,target=/usr/local/bundle/cache \
    bundle config set jobs "$(nproc)" && \
    bundle install && \
    rm -rf ~/.bundle\ "${BUNDLE_PATH}"/ruby/*/cache \
        "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

COPY . .

RUN bundle exec bootsnap precompile app/ lib/

RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile



FROM base

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

EXPOSE 3000

CMD ["tail", "-f", "/dev/null"]
