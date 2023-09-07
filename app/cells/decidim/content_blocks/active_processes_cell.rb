# frozen_string_literal: true

module Decidim
  module ContentBlocks
    class ActiveProcessesCell < Decidim::ViewModel
      def show
        render
      end

      def items
        (1..3).filter_map do |i|
          next if link_url(i).blank?

          {
            link_url: link_url(i),
            link_text: link_text(i),
            image_url: image_url_for(i),
            text_color: text_color(i)
          }
        end
      end

      def link_url(attribute)
        model.settings["link_url_#{attribute}"]
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

      def text_color(attribute)
        model.settings["text_color_#{attribute}"]
      end

      def button
        return unless button_text.present? && button_url.present?

        link_to button_text, button_url, class: "button hollow"
      end

      private

      def image_blob(attribute)
        model.images_container.send("image_#{attribute}").blob
      end

      def has_image?(attribute)
        image = model.images_container.send("image_#{attribute}")
        image.present? && image.attached?
      end

      def button_text
        translated_attribute(model.settings.button_text)
      end

      def button_url
        model.settings.button_url
      end
    end
  end
end
