# frozen_string_literal: true

module ConferenceOverride
  extend ActiveSupport::Concern

  included do
    def self.filtered_by_hashtag(hashtag)
      where("hashtag ILIKE ? OR hashtag ILIKE ? OR hashtag ILIKE ? OR hashtag ILIKE ? OR hashtag ILIKE ? OR hashtag ILIKE ?",
            "%#{hashtag}", "%##{hashtag}%", "% #{hashtag}", "%#{hashtag} ", "% ##{hashtag} %", "%#{hashtag.gsub(" ", "%")}%")
    end
  end
end
