# frozen_string_literal: true

module Decidim
  module Conferences
    class ConferenceSort
      def initialize(conferences)
        @conferences = conferences
      end

      def sort
        @conferences.sort do |a, b|
          if a.end_date < Date.current && b.end_date < Date.current
            a.end_date <=> b.end_date
          elsif a.end_date >= Date.current && b.end_date >= Date.current
            a.start_date <=> b.start_date
          else
            a.end_date < Date.current ? 1 : -1
          end
        end
      end
    end
  end
end
