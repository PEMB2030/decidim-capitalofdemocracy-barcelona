# frozen_string_literal: true

module Decidim
  module CardMCellOverride
    extend ActiveSupport::Concern

    included do
      include Decidim::ConferenceCellExtensions
    end
  end
end
