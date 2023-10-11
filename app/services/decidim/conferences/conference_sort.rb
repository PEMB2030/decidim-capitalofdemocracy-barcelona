# frozen_string_literal: true

module Decidim
  module Conferences
    class ConferenceSort
      def initialize(conferences)
        @conferences = conferences
      end

      def sort
        @conferences.sort_by do |conference|
          if conference.end_date < Date.current
            [1, conference.end_date]
          else
            [0, conference.start_date]
          end
        end
      end
    end
  end
end
