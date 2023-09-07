# frozen_string_literal: true

module ConferencesControllerOverride
  extend ActiveSupport::Concern

  included do
    private

    def hashtag_for_current_url
      @hashtag_for_current_url ||= find_hashtag_for_current_url
    end

    def find_hashtag_for_current_url
      Rails.application.secrets.custom_conference_types.find { |item| item[:url] == request.path }&.dig(:hashtag)
    end

    def published_conferences
      @published_conferences ||= conferences_query(Decidim::Conferences::OrganizationPublishedConferences)
    end

    def conferences
      @conferences ||= conferences_query(Decidim::Conferences::OrganizationPrioritizedConferences)
    end

    def collection
      conferences
    end

    def custom_hashtags
      @custom_hashtags ||= Rails.application.secrets.custom_conference_types.map { |item| item[:hashtag] }
    end

    def conferences_query(conference_class)
      conference_class.new(current_organization, current_user).query.tap do |query|
        query.merge!(Decidim::Conference.filtered_by_hashtag(hashtag_for_current_url)) if hashtag_for_current_url
      end
    end
  end
end
