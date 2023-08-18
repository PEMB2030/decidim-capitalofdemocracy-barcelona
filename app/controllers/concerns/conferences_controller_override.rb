# frozen_string_literal: true

module ConferencesControllerOverride
  extend ActiveSupport::Concern

  included do
    def current_hashtag
      conference_type = Rails.application.secrets.custom_conference_types.find do |item|
        item[:url] == request.path
      end
      conference_type[:hashtag] if conference_type
    end

    def published_conferences
      @published_conferences ||= begin
        conferences = Decidim::Conferences::OrganizationPublishedConferences.new(current_organization, current_user)

        if current_hashtag
          conferences_filtered_by_hashtag(conferences, current_hashtag)
        else
          conferences
        end
      end
    end

    def conferences
      @conferences ||= begin
        conferences = Decidim::Conferences::OrganizationPrioritizedConferences.new(current_organization, current_user)
        if current_hashtag
          conferences_filtered_by_hashtag(conferences, current_hashtag)
        else
          conferences
        end
      end
    end

    def conferences_filtered_by_hashtag(conferences, hashtag)
      conferences.query.merge(Decidim::Conference.filtered_by_hashtag(hashtag))
    end
  end
end
