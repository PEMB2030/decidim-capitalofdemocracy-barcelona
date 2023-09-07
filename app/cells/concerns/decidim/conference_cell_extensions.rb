# frozen_string_literal: true

module Decidim
  module ConferenceCellExtensions
    extend ActiveSupport::Concern

    def conference_class(model)
      custom_conference_types = Rails.application.secrets.custom_conference_types || []
      custom_conference_types.each do |item|
        return item[:key] if model.hashtag.include?(item[:hashtag])
      end
      ""
    end
  end
end
