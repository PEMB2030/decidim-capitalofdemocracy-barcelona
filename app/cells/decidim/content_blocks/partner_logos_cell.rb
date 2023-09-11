# frozen_string_literal: true

module Decidim
  module ContentBlocks
    class PartnerLogosCell < Cell::ViewModel
      def show
        render
      end

      def partner_images
        image_directory = Rails.public_path.join("partner_logos")
        Dir["#{image_directory}/*.png"].map do |file_path|
          "/partner_logos/#{File.basename(file_path)}"
        end
      end
    end
  end
end
