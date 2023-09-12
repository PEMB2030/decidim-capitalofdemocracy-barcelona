# frozen_string_literal: true

module Decidim
  module ContentBlocks
    class PartnerLogosCell < Cell::ViewModel
      def show
        render
      end

      def partner_images(row)
        dir = "partners#{row}/"
        image_directory = Rails.public_path.join(dir.to_s)
        Dir["#{image_directory}/*.png"].map do |file_path|
          "/#{dir}/#{File.basename(file_path)}"
        end
      end

      def first_row
        @first_row ||= partner_images(1)
      end

      def second_row
        @second_row ||= partner_images(2)
      end

      def third_row
        @third_row ||= partner_images(3)
      end
    end
  end
end
