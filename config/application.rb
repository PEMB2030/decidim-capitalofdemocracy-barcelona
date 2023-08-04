# frozen_string_literal: true

require_relative "boot"

# require "rails/all"
require "decidim/rails"
require "action_cable/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DecidimCapitalitatDev
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # generic overrides
    config.to_prepare do
      Decidim::StatisticCell.include(Decidim::StatisticCellOverride)
    end
  end
end
