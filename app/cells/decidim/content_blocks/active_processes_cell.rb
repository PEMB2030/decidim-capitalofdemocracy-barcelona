# frozen_string_literal: true

module Decidim
  module ContentBlocks
    class ActiveProcessesCell < Decidim::ViewModel
      def show
        render
      end

      def link_url(attribute)
        translated_attribute(model.settings["link_url_#{attribute}"])
      end

      def link_text(attribute)
        translated_attribute(model.settings["link_text_#{attribute}"])
      end

      def image_url_for(attribute)
        return unless has_image?(attribute)

        blob = image_blob(attribute)
        return if blob.nil?

        variant = blob.variant(resize_to_fit: [400, 300]).processed
        url_for(variant)
      end

      def has_image?(attribute)
        image = model.images_container.send("image_#{attribute}")
        image.present? && image.attached?
      end

      private

      def image_blob(attribute)
        model.images_container.send("image_#{attribute}").blob
      end
    end
  end
end
