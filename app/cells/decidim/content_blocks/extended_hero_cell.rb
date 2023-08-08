# frozen_string_literal: true

module Decidim
  module ContentBlocks
    class ExtendedHeroCell < Decidim::ContentBlocks::HeroCell
      def show
        render
      end

      def welcome_text
        if translated_welcome_text.blank?
          default_welcome_text
        else
          processed_welcome_text
        end
      end

      def subtitle_text
        decidim_sanitize(translated_subtitle) if translated_subtitle
      end

      private

      def translated_welcome_text
        translated_attribute(model.settings.welcome_title)
      end

      def translated_subtitle
        translated_attribute(model.settings.subtitle)
      end

      def default_welcome_text
        t("decidim.pages.home.hero.welcome", organization: current_organization.name)
      end

      def processed_welcome_text
        text_parts = translated_welcome_text.split("<br>", 2)
        content = content_tag(:span, sanitize(text_parts[0]), class: "no-wrap")
        content + (text_parts[1] ? ("<br>".html_safe + sanitize(text_parts[1])) : "")
      end

      # A MD5 hash of model attributes because is needed because
      # the model doesn't respond to cache_key_with_version nor updated_at method
      def cache_hash
        hash = []
        hash << "decidim/content_blocks/hero"
        hash << Digest::MD5.hexdigest(model.attributes.to_s)
        hash << current_organization.cache_key_with_version
        hash << I18n.locale.to_s
        hash << background_image

        hash.join(Decidim.cache_key_separator)
      end
    end
  end
end
