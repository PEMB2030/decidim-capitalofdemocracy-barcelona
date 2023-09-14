# frozen_string_literal: true

module Decidim
  module CardMCellOverride
    def title
      translated_attribute(model.title)
    end
  end
end
