# frozen_string_literal: true

# extra menus defined in secrets.yml
Decidim.menu :menu do |menu|
  custom_conference_types = Rails.application.secrets.custom_conference_types || []
  custom_conference_types.each do |item|
    hashtag = item[:hashtag]
    options = {}
    options[:position] = item[:position].to_i if item[:position]
    options[:active] = item[:active].to_sym if item[:active]
    options[:icon_name] = item[:icon_name].to_s if item[:icon_name]
    options[:if] = Decidim::Conference.exists?(Decidim::Conference.filtered_by_hashtag(hashtag))
    menu.add_item item[:key], I18n.t(item[:key], scope: "decidim.conferences.custom_conference_types"), item[:url], options
  end
end

Rails.application.config.to_prepare do
  Decidim::StatisticCell.include(Decidim::StatisticCellOverride)
  Decidim::Conference.include(ConferenceOverride)
end

Rails.application.config.after_initialize do
  Decidim::Conferences::ConferencesController.include(ConferencesControllerOverride)
end

Rails.application.config do
  initializer "capitalitat.homepage_content_blocks" do
    config.to_prepare do
      Decidim.content_blocks.register(:homepage, :active_processes) do |content_block|
        content_block.cell = "decidim/content_blocks/active_processes"
        content_block.settings_form_cell = "decidim/content_blocks/active_processes_settings_form"
        content_block.public_name_key = "decidim.content_blocks.active_processes.name"

        content_block.settings do |settings|
          settings.attribute :button_text, type: :text, translated: true
          settings.attribute :button_url, type: :text

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
