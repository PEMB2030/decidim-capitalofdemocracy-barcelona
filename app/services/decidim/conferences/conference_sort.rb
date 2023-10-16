# frozen_string_literal: true

module Decidim
  module Conferences
    class ConferenceSort
      def initialize(collection)
        @collection = collection
      end

      attr_reader :collection

      def sort
        conferences.reorder(new_order)
      end

      private

      def conferences
        Conference.where(id: collection)
      end

      def new_order
        Arel.sql("array_position(ARRAY[#{sorted_ids.join(",")}], id::int)")
      end

      def sorted_ids
        [
          *upcoming_conferences_sorted.ids,
          *past_conferences_sorted.ids
        ]
      end

      def upcoming_conferences_sorted
        conferences.upcoming.order(start_date: :asc)
      end

      def past_conferences_sorted
        conferences.past.order(end_date: :desc)
      end
    end
  end
end
