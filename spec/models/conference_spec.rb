# frozen_string_literal: true

require "rails_helper"

RSpec.describe ConferenceOverride, type: :model do
  describe ".filtered_by_hashtag" do
    let(:organization) { create(:organization) }

    let!(:conference1) { create(:conference, organization: organization, hashtag: "#city") }
    let!(:conference2) { create(:conference, organization: organization, hashtag: "welcome to city") }
    let!(:conference3) { create(:conference, organization: organization, hashtag: "cityofdreams") }
    let!(:conference4) { create(:conference, organization: organization, hashtag: "sunny city") }

    context "when the hashtag exists in the middle of the string" do
      it "returns the conference that contains the hashtag" do
        expect(Decidim::Conference.filtered_by_hashtag("city")).to match_array([conference2, conference4])
      end
    end

    context "when the hashtag is at the beginning of the string" do
      it "returns the conference that starts with the hashtag" do
        expect(Decidim::Conference.filtered_by_hashtag("city")).to include(conference1)
      end
    end

    context "when the hashtag is part of a word" do
      it "returns the conference where the hashtag is part of a word" do
        expect(Decidim::Conference.filtered_by_hashtag("city")).to include(conference3)
      end
    end
  end
end
