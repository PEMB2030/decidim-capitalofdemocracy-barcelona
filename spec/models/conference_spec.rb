# frozen_string_literal: true

require "rails_helper"

RSpec.describe ConferenceOverride, type: :model do
  describe ".filtered_by_hashtag" do
    let(:organization) { create(:organization) }

    let!(:conference1) { create(:conference, organization: organization, hashtag: "#city") }
    let!(:conference2) { create(:conference, organization: organization, hashtag: "welcome to city ") }
    let!(:conference3) { create(:conference, organization: organization, hashtag: "cityofdreams") }
    let!(:conference4) { create(:conference, organization: organization, hashtag: "sunny city") }

    it "returns the conference that contains the hashtag" do
      result = Decidim::Conference.filtered_by_hashtag("city")
      expect(result).to match_array([conference1, conference2, conference4])
      expect(result).not_to include(conference3)
    end
  end
end
