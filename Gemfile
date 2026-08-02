source "https://rubygems.org"

# Rails ve Core Bileşenler
gem "rails", "~> 7.2.3", ">= 7.2.3.1"
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "jbuilder"
gem "ostruct"

# Ön Yüz (Frontend) ve JavaScript
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails", "~> 4.4"

# Veritabanları ve Depolama (Hem Local hem Docker için SQLite3)
gem "sqlite3", ">= 1.4"
gem "image_processing", "~> 1.2"
gem "activemodel-serializers-xml"
gem 'faker'
gem 'will_paginate', '~> 4.0'

# WebSocket (Action Cable) için Redis bağımlılığı
gem "redis", ">= 4.0.1"

# Güvenlik ve Şifreleme (Kullanıcı girişleri için)
gem "bcrypt", "~> 3.1.7"

# Windows Uyumluluğu
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Boot Hızlandırıcı (Docker'da kilitlenmeye sebep olabileceği için geçici olarak devre dışı bırakıldı)
gem "bootsnap", require: false

gem "rails-controller-testing"

# GELİŞTİRME VE TEST ORTAMI (ORTAK)
group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  # Kitabın renkli test çıktıları için aradığı eksik gem:
  gem "minitest-reporters"

  # Dosya izleyicileri hem test hem development'ta çalışmalı
  gem "listen"
  gem "guard"
  gem "guard-minitest"
end

# SADECE GELİŞTİRME ORTAMI
group :development do
  gem "web-console"
  gem "guard-livereload" # Sadece tarayıcıyı yenileyeceği için development yeterli
  gem "solargraph"
end

# SADECE TEST ORTAMI
group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
