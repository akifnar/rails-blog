ARG RUBY_VERSION=3.4.9
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# Temel çalışma katmanına libyaml-0-2 paketini ekledik
RUN apt-get update -qq && \
  apt-get install --no-install-recommends -y curl libjemalloc2 libvips libyaml-0-2 && \
  rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV RAILS_ENV="production" \
  BUNDLE_DEPLOYMENT="0" \
  BUNDLE_PATH="/usr/local/bundle" \
  BUNDLE_WITHOUT="development"



FROM base AS build

# Derleme katmanına psych gem'inin aradığı libyaml-dev paketini ekledik
RUN apt-get update -qq && \
  apt-get install --no-install-recommends -y build-essential git pkg-config libyaml-dev && \
  rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY Gemfile Gemfile.lock ./

RUN bundle install && \
  rm -rf ~/.bundle\ "${BUNDLE_PATH}"/ruby/*/cache \
  "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
  bundle exec bootsnap precompile --gemfile

COPY . .

RUN bundle exec bootsnap precompile app/ lib/

RUN SECRET_KEY_BASE_DUMMY=1 DATABASE_URL=null://db/dev/null ./bin/rails assets:precompile





FROM base

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails


RUN useradd rails --create-home --shell /bin/bash && \
  chown -R rails:rails log storage tmp
USER rails:rails


EXPOSE 3000

CMD ["tail", "-f", "/dev/null"]
