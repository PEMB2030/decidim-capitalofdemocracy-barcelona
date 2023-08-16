# frozen_string_literal: true

# extra menus defined in secrets.yml
Decidim.menu :menu do |menu|
  custom_conference_types = Rails.application.secrets.custom_conference_types || []
  custom_conference_types.each do |item|
    options = {}
    options[:position] = item[:position].to_i if item[:position]
    options[:active] = item[:active].to_sym if item[:active]
    options[:icon_name] = item[:icon_name].to_s if item[:icon_name]
    menu.add_item item[:key], I18n.t(item[:key], scope: "decidim.conferences.custom_conference_types"), item[:url], options
  end
end

# Rails.configuration.middleware.use ConferencesScoper
