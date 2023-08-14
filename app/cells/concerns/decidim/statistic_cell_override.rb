# frozen_string_literal: true

module Decidim
  module StatisticCellOverride
    extend ActiveSupport::Concern

    included do
      include Decidim::IconHelper
    end
  end
end
