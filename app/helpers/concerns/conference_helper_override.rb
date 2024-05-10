# frozen_string_literal: true

module ConferenceHelperOverride
  extend ActiveSupport::Concern

  included do
    alias_method :decidim_conference_nav_items, :conference_nav_items

    def conference_nav_items(participatory_space)
      @conference_nav_items ||= begin
        divisor = Rails.application.secrets.speakers_divisor[participatory_space.slug.to_sym]
        items = decidim_conference_nav_items(participatory_space)
        items.first[:name] = I18n.t("capital.speakers_divisor.#{divisor.first[:name]}") if participatory_space.speakers.exists? && divisor && divisor&.first&.[](:name)
        items
      end
    end
  end
end
