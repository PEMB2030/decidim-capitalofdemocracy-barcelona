# frozen_string_literal: true

module ConferenceOverride
  extend ActiveSupport::Concern

  included do
    scope :past, -> { where(arel_table[:end_date].lt(Date.current)) }
    scope :upcoming, -> { where(arel_table[:end_date].gteq(Date.current)) }

    def self.filtered_by_hashtag(hashtag)
      where("(CONCAT(' ', hashtag, ' ') ILIKE ?) OR (CONCAT(' ', hashtag, ' ') ILIKE ?)", "% #{hashtag} %", "% ##{hashtag} %")
    end
  end
end
