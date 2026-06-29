source "https://rubygems.org"

# Senin güncel Rails sürümün
gem "rails", "~> 7.2.3", ">= 7.2.3.1"

# Asset pipeline ve sunucu bileşenleri
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "bootsnap", require: false

# Ön yüz ve API araçları
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tailwindcss-rails", "~> 4.6"

# Windows için uyumluluk katmanı
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Canlı ortam (Heroku / Render vb.) için PostgreSQL
group :production do
  gem "pg", "~> 1.5"
end

# Geliştirme ve Ortak Test Ortamı
group :development, :test do
  gem "sqlite3", ">= 1.4"
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false

  # Kitapta kullanılan ekstra test araçları (Tek bir yerde toplandı, kopyaları silindi!)
  gem "rails-controller-testing"
  gem "minitest"
  gem "minitest-reporters"
  gem "guard"
  gem "listen"
  gem "guard-minitest"
end

# Sadece Geliştirme Ortamı
group :development do
  gem "web-console"
end

# Sadece Test Ortamı
group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
