# frozen_string_literal: true

require "rails_helper"

module Decidim
  module Conferences
    describe ConferencesController, type: :controller do
      include ConferencesControllerOverride
      routes { Decidim::Conferences::Engine.routes }

      let(:organization) { create(:organization) }

      let!(:published1) { create(:conference, :published, organization: organization, hashtag: "actesciutat") }
      let!(:published2) { create(:conference, :published, organization: organization, hashtag: "actesparalels") }
      let!(:published_no_hashtag) { create(:conference, :published, organization: organization, hashtag: "") }
      let!(:promoted) { create(:conference, :published, :promoted, organization: organization, hashtag: "actesciutat") }
      let!(:promoted_no_hashtag) { create(:conference, :published, :promoted, organization: organization, hashtag: "") }

      before do
        request.env["decidim.current_organization"] = organization
        allow(Rails.application.secrets).to receive(:custom_conference_types).and_return(
          [
            {
              url: "/conferences/city",
              hashtag: "actesciutat"
            }
          ])
      end

      describe "published_conferences" do
        context "when the custom hashtag exists" do
          before do
            request.env['PATH_INFO'] = '/conferences/city'
            get :index
          end

          it "includes only conferences with the matching hashtag" do
            expect(controller.published_conferences).to match_array([published1, promoted])
          end
        end

        context "when the custom hashtag does not exist" do
          it "includes all published conferences except those with custom hashtag" do
            get :index

            expect(controller.published_conferences).to match_array([published2, published_no_hashtag, promoted_no_hashtag])
          end
        end
      end

      describe "conferences" do
        context "when the custom hashtag exists" do
          before do
            request.env['PATH_INFO'] = '/conferences/city'
            get :index
          end

          it "includes only conferences with the matching hashtag" do
            expect(controller.helpers.conferences).to match_array([published1, promoted])
          end
        end

        context "when the custom hashtag does not exist" do
          it "includes all conferences except those with custom hashtags" do
            get :index

            expect(controller.helpers.conferences).to match_array([published2, published_no_hashtag, promoted_no_hashtag])
          end
        end
      end

      describe "promoted_conferences" do
        context "when the custom hashtag exists" do
          before do
            request.env['PATH_INFO'] = '/conferences/city'
            get :index
          end

          it "includes only promoted conferences with the matching hashtag" do
            expect(controller.helpers.promoted_conferences).to match_array([promoted])
          end
        end

        context "when the custom hashtag does not exist" do
          it "includes all promoted conferences except those with custom hashtag" do
            get :index

            expect(controller.helpers.promoted_conferences).to match_array([promoted_no_hashtag])
          end
        end
      end
    end
  end
end
