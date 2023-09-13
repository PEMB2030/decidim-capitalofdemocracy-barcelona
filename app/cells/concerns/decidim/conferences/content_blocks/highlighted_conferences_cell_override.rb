# frozen_string_literal: true

module Decidim
  module Conferences
    module ContentBlocks
      module HighlightedConferencesCellOverride
        def highlighted_conferences
          Decidim::Conference.where(organization: current_organization, promoted: true).order(start_date: :asc)
        end
      end
    end
  end
end
