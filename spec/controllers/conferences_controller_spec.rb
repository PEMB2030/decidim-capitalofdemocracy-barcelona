# frozen_string_literal: true

require "rails_helper"

module Decidim
  module Conferences
    describe ConferencesController, type: :controller do
      include ConferencesControllerOverride
      routes { Decidim::Conferences::Engine.routes }

      let(:organization) { create(:organization) }

      let!(:published1) { create(:conference, :published, organization: organization, hashtag: "ciutat") }
      let!(:published2) { create(:conference, :published, organization: organization, hashtag: "activitat") }
      let!(:published3) { create(:conference, :published, organization: organization, hashtag: "internacional") }

      before do
        request.env["decidim.current_organization"] = organization
      end

      describe "conferences" do
        it "includes published conferences" do
          expect(controller.helpers.conferences).to match_array([published1, published2, published3])
        end
      end

      describe "city conferences" do
        before do
          allow(Rails.application.secrets).to receive(:custom_conference_types).and_return([{ type: "city", hashtag: "ciutat" }])
        end

        it "includes only published conferences with hashtag ciutat" do
          expect(controller.helpers.conferences).to match_array([published1])
        end
      end

      describe "activity conferences" do
        before do
          allow(Rails.application.secrets).to receive(:custom_conference_types).and_return([{ type: "activity", hashtag: "activitat" }])
        end

        it "includes only published conferences with hashtag activitat" do
          expect(controller.helpers.conferences).to match_array([published2])
        end
      end

      describe "international conferences" do
        before do
          allow(Rails.application.secrets).to receive(:custom_conference_types).and_return([{ type: "international", hashtag: "internacional" }])
        end

        it "includes only published conferences with hashtag internacional" do
          expect(controller.helpers.conferences).to match_array([published3])
        end
      end
    end
  end
end
