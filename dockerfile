ARG RUBY_VERSION=3.4.9
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# Geliştirme ortamı için gerekli temel paketleri ve derleyicileri en baştan kuruyoruz
RUN apt-get update -qq && \
  apt-get install --no-install-recommends -y \
  build-essential \
  curl \
  git \
  libjemalloc2 \
  libvips \
  libyaml-0-2 \
  libyaml-dev \
  pkg-config \
  sqlite3 \
  make \
  gcc \
  g++ && \
  rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Ortam değişkenlerini DEVELOPMENT moduna çekiyoruz
ENV RAILS_ENV="development" \
  BUNDLE_DEPLOYMENT="0" \
  BUNDLE_PATH="/usr/local/bundle"

# Proje dosyalarını ve Gemfile'ı kopyalıyoruz
COPY Gemfile Gemfile.lock ./

# Gem'leri eksiksiz yüklüyoruz (Artık development dışlanmıyor)
RUN bundle install

COPY . .

# Klasörlerin izinlerini rails kullanıcısına vermeden önce root olarak temizliyoruz
RUN mkdir -p log storage tmp db && \
    chmod -R 777 log storage tmp db "${BUNDLE_PATH}"

# Rails kullanıcısını oluşturup yetkilendiriyoruz
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails /rails "${BUNDLE_PATH}"

USER rails:rails

EXPOSE 3000

CMD ["tail", "-f", "/dev/null"]