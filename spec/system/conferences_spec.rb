# frozen_string_literal: true

require "rails_helper"

describe "Visit conferences" do
  let!(:organization) { create(:organization) }
  let!(:conference_activity) { create(:conference, :published, promoted: false, organization:, hashtag: hashtag_activity, start_date:, end_date:) }
  let!(:conference_city) { create(:conference, :published, promoted: false, organization:, hashtag: hashtag_city) }
  let!(:conference_international) { create(:conference, :published, promoted: false, organization:, hashtag: hashtag_international, start_date:, end_date:) }

  let(:hashtag_activity) { "activitat" }
  let(:hashtag_city) { "ciutat" }
  let(:hashtag_international) { "internacional" }
  let(:start_date) { Date.parse("2024-01-25") }
  let(:end_date) { Date.parse("2024-03-25") }

  let(:conferences) do
    {
      "activity" => conference_activity,
      "city" => conference_city,
      "international" => conference_international
    }
  end

  before do
    switch_to_host(organization.host)
    visit decidim_conferences.conferences_path
  end

  shared_examples "checks the conference link" do |type|
    it "shows the #{type} conference link and its content" do
      expect(page).to have_content(conferences[type].title["en"])
      expect(page).to have_css(".card__grid", count: 3)
    end
  end

  describe "Checking each conference type link" do
    conference_types_local = %w(city international activity)

    conference_types_local.each do |type|
      it_behaves_like "checks the conference link", type
    end
  end

  context "when hashtag with #" do
    let!(:hashtag_city) { "#ciutat" }

    it_behaves_like "checks the conference link", "city"
  end

  context "when hashtag contains spaces" do
    let!(:hashtag_city) { " ciutat " }

    it_behaves_like "checks the conference link", "city"
  end

  context "when conference has a date" do
    it "shows the conference date as its content" do
      expect(page).to have_content("25 Jan")
      expect(page).to have_content("25 Mar")

      within "#conferences-grid" do
        expect(page).to have_css(".card__grid", count: 3)
      end
    end
  end
end
