# Debian tabanlı resmi Ruby imajı
FROM docker.io/library/ruby:3.4-slim AS base

WORKDIR /rails

# İstediğin Debian paketlerinin eksiksiz kurulumu
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
    g++ \
    bash && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Ortam değişkenleri
ENV RAILS_ENV="development" \
    BUNDLE_DEPLOYMENT="0" \
    BUNDLE_PATH="/usr/local/bundle"

# Debian üzerinde 'rails' kullanıcısını ve gruplarını oluşturup izinleri veriyoruz
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    mkdir -p /rails/log /rails/storage /rails/tmp /rails/db "${BUNDLE_PATH}" && \
    chown -R rails:rails /rails "${BUNDLE_PATH}"

# Proje dosyalarını kopyala
COPY --chown=rails:rails . .

# Kullanıcıya geçiş
USER rails:rails

EXPOSE 3000

# Konteyner açık kalsın diye arka planda bekletiyoruz
CMD ["tail", "-f", "/dev/null"]
