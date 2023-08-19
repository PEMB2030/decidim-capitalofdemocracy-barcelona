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
      @published_conferences ||= if current_hashtag
                                   conferences_with_hashtag_filter(Decidim::Conferences::OrganizationPublishedConferences.new(current_organization, current_user))
                                 else
                                   Decidim::Conferences::OrganizationPublishedConferences.new(current_organization, current_user)
                                 end
    end

    def conferences
      @conferences ||= if current_hashtag
                         conferences = Decidim::Conferences::OrganizationPrioritizedConferences.new(current_organization, current_user)
                         conferences_with_hashtag_filter(conferences)
                       else
                         Decidim::Conferences::OrganizationPrioritizedConferences.new(current_organization, current_user)
                       end
    end

    def promoted_conferences
      @promoted_conferences ||= current_hashtag ? promoted_filtered_by_hashtag(conferences) : Decidim::Conference.promoted
    end

    def promoted_filtered_by_hashtag(conferences)
      conferences.merge(Decidim::Conference.promoted.filtered_by_hashtag(current_hashtag))
    end

    def conferences_with_hashtag_filter(conferences)
      conferences.query.merge(Decidim::Conference.filtered_by_hashtag(current_hashtag))
    end
  end
end
