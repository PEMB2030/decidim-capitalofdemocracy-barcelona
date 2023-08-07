# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

# DECIDIM_VERSION = { github: "decidim/decidim", branch: "release/0.27-stable" }.freeze
DECIDIM_VERSION = "0.27.3"

gem "decidim", DECIDIM_VERSION
gem "decidim-conferences", DECIDIM_VERSION
# gem "decidim-consultations", DECIDIM_VERSION
# gem "decidim-elections", DECIDIM_VERSION
# gem "decidim-initiatives", DECIDIM_VERSION
gem "decidim-templates", DECIDIM_VERSION

gem "decidim-decidim_awesome", github: "decidim-ice/decidim-module-decidim_awesome"
# gem "decidim-newsletter_agenda", github: "openpoke/decidim-module-newsletter_agenda"
gem "decidim-term_customizer", github: "mainio/decidim-module-term_customizer"

gem "bootsnap", "~> 1.7"

gem "puma", ">= 5.0.0"

gem "wicked_pdf", "~> 2.1"

gem "deface", ">= 1.9"

group :development, :test do
  gem "faker", "~> 2.14"
  gem "byebug", "~> 11.0", platform: :mri

  gem "brakeman"
  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web"
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
  gem "rubocop-faker"
  gem "web-console"
end

group :production do
  gem "aws-sdk-s3", require: false
  gem "sidekiq"
  gem "sidekiq-cron"
end
