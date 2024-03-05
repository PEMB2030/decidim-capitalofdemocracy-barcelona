# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = { github: "decidim/decidim", branch: "release/0.28-stable" }.freeze

gem "decidim", DECIDIM_VERSION
gem "decidim-conferences", DECIDIM_VERSION
# gem "decidim-consultations", DECIDIM_VERSION
# gem "decidim-elections", DECIDIM_VERSION
# gem "decidim-initiatives", DECIDIM_VERSION
gem "decidim-templates", DECIDIM_VERSION

gem "decidim-decidim_awesome", github: "decidim-ice/decidim-module-decidim_awesome", branch: "constrain-fixes"
gem "decidim-newsletter_agenda", github: "openpoke/decidim-module-newsletter_agenda", branch: "upgrade-28"
gem "decidim-term_customizer", github: "mainio/decidim-module-term_customizer", branch: "master"

gem "bootsnap", "~> 1.7"

gem "puma", ">= 5.0.0"

gem "wicked_pdf", "~> 2.1"

gem "deface", ">= 1.9"
gem "omniauth-decidim"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri
  gem "faker", "~> 3.2"

  gem "brakeman"
  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web"
  gem "listen"
  gem "rubocop-faker"
  gem "spring"
  gem "spring-watcher-listen"
  gem "web-console"
end

group :production do
  gem "aws-sdk-s3", require: false
  gem "sidekiq"
  gem "sidekiq-cron"
end
