# frozen_string_literal: true

module Decidim
  # This class deals with uploading active processes section images to the front page
  # content blocks.
  class ActiveProcessesImageUploader < Decidim::ImageUploader
    set_variants do
      { big: { resize_to_fill: [600, 600] } }
    end

    def max_image_height_or_width
      3000
    end
  end
end
