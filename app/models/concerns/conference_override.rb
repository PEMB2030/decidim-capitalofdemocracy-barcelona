# frozen_string_literal: true

module ConferenceOverride
  extend ActiveSupport::Concern

  included do
    def self.filtered_by_hashtag(hashtag)
      where("(CONCAT(' ', hashtag, ' ') ILIKE ?) OR (CONCAT(' ', hashtag, ' ') ILIKE ?)", "% #{hashtag} %", "% ##{hashtag} %")
    end
  end
end
