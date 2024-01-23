# frozen_string_literal: true

require "rails_helper"

RSpec.describe ConferenceOverride do
  describe ".filtered_by_hashtag" do
    let(:organization) { create(:organization) }

    let!(:found) do
      [
        create(:conference, organization:, hashtag: "#city"),
        create(:conference, organization:, hashtag: "city"),
        create(:conference, organization:, hashtag: " city "),
        create(:conference, organization:, hashtag: "city "),
        create(:conference, organization:, hashtag: " city"),
        create(:conference, organization:, hashtag: "welcome to city "),
        create(:conference, organization:, hashtag: "sunny city"),
        create(:conference, organization:, hashtag: "the city in the middle"),
        create(:conference, organization:, hashtag: "the #city in the middle")
      ]
    end

    let!(:not_found) do
      [
        create(:conference, organization:, hashtag: "cityofdreams"),
        create(:conference, organization:, hashtag: "#cityofdreams"),
        create(:conference, organization:, hashtag: "my cityofdreams is missing"),
        create(:conference, organization:, hashtag: "my #cityofdreams is missing")
      ]
    end

    it "returns all conferences" do
      expect(Decidim::Conference.all).to match_array(found + not_found)
    end

    it "returns the conference that contains the hashtag" do
      result = Decidim::Conference.filtered_by_hashtag("city")
      expect(result).to match_array(found)
    end
  end
end
