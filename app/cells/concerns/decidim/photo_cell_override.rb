# frozen_string_literal: true

module Decidim
  module PhotoCellOverride
    extend ActiveSupport::Concern

    def image_thumb
      image_tag model.big_url, alt: t("alt", scope: "decidim.conferences.photo.image.attributes")
    end
  end
end
