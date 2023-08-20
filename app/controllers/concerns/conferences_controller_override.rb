# frozen_string_literal: true

module ConferencesControllerOverride
  extend ActiveSupport::Concern

  included do
    def hashtag_for_current_url
      @hashtag_for_current_url ||= Rails.application.secrets.custom_conference_types.find do |item|
        item[:url] == request.path
      end&.dig(:hashtag)
    end

    def published_conferences
      @published_conferences ||= conferences_query(Decidim::Conferences::OrganizationPublishedConferences)
    end

    def conferences
      @conferences ||= conferences_query(Decidim::Conferences::OrganizationPrioritizedConferences)
    end

    alias collection conferences

    def promoted_conferences
      @promoted_conferences ||= hashtag_for_current_url ? promoted_filtered_by_hashtag(conferences) : promoted_conferences_without_custom_hashtag(Decidim::Conference.promoted)
    end

    private

    def custom_hashtags
      @custom_hashtags ||= Rails.application.secrets.custom_conference_types.map { |item| item[:hashtag] }
    end

    def conferences_query(conference_class)
      conferences = conference_class.new(current_organization, current_user)
      hashtag_for_current_url ? conferences_with_custom_hashtag_filter(conferences) : conferences_without_custom_hashtag(conferences)
    end

    def conferences_with_custom_hashtag_filter(conferences)
      conferences.query.merge(Decidim::Conference.filtered_by_hashtag(hashtag_for_current_url))
    end

    def conferences_without_custom_hashtag(conferences)
      conferences.query.to_a.reject do |conference|
        conference_hashtags = conference.hashtag.split(" ")
        (conference_hashtags & custom_hashtags).any?
      end
    end

    def promoted_filtered_by_hashtag(conferences)
      conferences.merge(Decidim::Conference.promoted.filtered_by_hashtag(hashtag_for_current_url))
    end

    def promoted_conferences_without_custom_hashtag(conferences)
      conferences.select do |conference|
        conference_hashtags = conference.hashtag.split(" ")
        (conference_hashtags & custom_hashtags).empty?
      end
    end
  end
end
