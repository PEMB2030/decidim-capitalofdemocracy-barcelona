# frozen_string_literal: true

module ConferencesControllerOverride
  extend ActiveSupport::Concern

  included do
    private

    def hashtag_for_current_type
      @hashtag_for_current_type ||= find_hashtag_for_current_type
    end

    def find_hashtag_for_current_type
      type = params[:type]
      Rails.application.secrets.custom_conference_types.find { |item| item[:key] == type }&.dig(:hashtag)
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

    def promoted_conferences
      @promoted_conferences ||= conferences.promoted
    end

    def custom_hashtags
      @custom_hashtags ||= Rails.application.secrets.custom_conference_types.map { |item| item[:hashtag] }
    end

    def conferences_query(conference_class)
      conference_class.new(current_organization, current_user).query.tap do |query|
        query.merge!(Decidim::Conference.filtered_by_hashtag(hashtag_for_current_type)) if hashtag_for_current_type
      end
    end
  end
end
