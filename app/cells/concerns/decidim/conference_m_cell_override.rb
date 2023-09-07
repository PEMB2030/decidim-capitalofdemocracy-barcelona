# frozen_string_literal: true

module Decidim
  module ConferenceMCellOverride
    extend ActiveSupport::Concern

    included do
      include Decidim::ConferenceCellExtensions
    end
  end
end
