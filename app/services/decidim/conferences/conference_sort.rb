# frozen_string_literal: true

module Decidim
  module Conferences
    class ConferenceSort
      def initialize(collection)
        @collection = collection
      end

      attr_reader :collection

      def sort
        converences.reorder(new_order)
      end

      private

      def converences
        Conference.where(id: collection)
      end

      def new_order
        Arel.sql("POSITION(id::text IN '#{sorted_ids.join(",")}')")
      end

      def sorted_ids
        [
          *upcoming_converences_sorted.ids,
          *past_converences_sorted.ids
        ]
      end

      def upcoming_converences_sorted
        converences.where(Conference.arel_table[:end_date].gteq(Time.current)).order(start_date: :asc)
      end

      def past_converences_sorted
        converences.where(Conference.arel_table[:end_date].lteq(Time.current)).order(end_date: :desc)
      end
    end
  end
end
