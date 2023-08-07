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

    initializer "decidim.core.homepage_content_blocks" do
      Decidim.content_blocks.register(:homepage, :active_processes) do |content_block|
        content_block.cell = "decidim/content_blocks/active_processes"
        content_block.settings_form_cell = "decidim/content_blocks/active_processes_settings_form"
        content_block.public_name_key = "decidim.content_blocks.active_processes.name"

        content_block.settings do |settings|
          (1..3).each do |i|
            settings.attribute "link_url_#{i}".to_sym, type: :text
            settings.attribute "link_text_#{i}".to_sym, type: :text, translated: true
            settings.attribute "text_color_#{i}".to_sym, type: :string
          end
        end

        (1..3).each do |i|
          content_block.images << {
            name: "image_#{i}".to_sym,
            uploader: "Decidim::ActiveProcessesImageUploader"
          }
        end

        content_block.default!
      end

      Decidim.content_blocks.register(:homepage, :extended_hero) do |content_block|
        content_block.cell = "decidim/content_blocks/extended_hero"
        content_block.settings_form_cell = "decidim/content_blocks/extended_hero_settings_form"
        content_block.public_name_key = "decidim.content_blocks.extended_hero.name"

        content_block.settings do |settings|
          settings.attribute :welcome_title, type: :text, translated: true
          settings.attribute :subtitle, type: :text, translated: true
        end

        content_block.images = [
          {
            name: :background_image,
            uploader: "Decidim::HomepageImageUploader"
          }
        ]

        content_block.default!
      end
    end
  end
end
