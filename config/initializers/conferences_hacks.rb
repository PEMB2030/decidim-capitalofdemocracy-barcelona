# frozen_string_literal: true

Rails.application.config.to_prepare do
  Decidim::Conferences::ContentBlocks::HighlightedConferencesCell.prepend(Decidim::Conferences::ContentBlocks::HighlightedConferencesCellOverride)
  Decidim::StatisticCell.include(Decidim::StatisticCellOverride)
  # Decidim::CardMCell.prepend(Decidim::CardMCellOverride)
  # Decidim::CardMCell.include(Decidim::ConferenceCellExtensions)
  # Decidim::Conferences::ConferenceMCell.include(Decidim::ConferenceCellExtensions)
  # Decidim::Conferences::PhotoCell.prepend(Decidim::PhotoCellOverride)
  Decidim::Conference.include(ConferenceOverride)
end

Rails.application.config.after_initialize do
  Decidim::Conferences::ConferencesController.include(ConferencesControllerOverride)
end

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

Decidim.content_blocks.register(:homepage, :promo_video) do |content_block|
  content_block.cell = "decidim/content_blocks/promo_video"
  content_block.public_name_key = "decidim.content_blocks.promo_video.name"
  content_block.default!
end

Decidim.content_blocks.register(:homepage, :partner_logos) do |content_block|
  content_block.cell = "decidim/content_blocks/partner_logos"
  content_block.public_name_key = "decidim.content_blocks.partner_logos.name"
  content_block.default!
end
