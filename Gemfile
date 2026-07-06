source "https://rubygems.org"


gem "rails", "~> 7.2.3", ">= 7.2.3.1"


gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "bootsnap", require: false


gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tailwindcss-rails", "~> 4.6"
gem "bcrypt", ">= 3.1.20"

gem "tzinfo-data", platforms: %i[ windows jruby ]


group :production do
  gem "pg", "~> 1.5"
end


group :development, :test do
  gem "sqlite3", ">= 1.4"
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false


  gem "rails-controller-testing"
  gem "minitest"
  gem "minitest-reporters"
  gem "guard"
  gem "listen"
  gem "guard-minitest"
end


group :development do
  gem "web-console"
end


group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
