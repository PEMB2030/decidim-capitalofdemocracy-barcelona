# frozen_string_literal: true

module Decidim
  module ContentBlocks
    class PromoVideoCell < Decidim::ViewModel
      def video_url
        case I18n.locale
        when :en
          # change to "en" when available
          "/ecod_ca.mp4"
        else
          "/ecod_ca.mp4"
        end
      end
    end
  end
end
