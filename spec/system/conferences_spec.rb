# frozen_string_literal: true

require "rails_helper"

describe "Visit conferences", type: :system do
  let!(:organization) { create :organization }
  let!(:conference_activity) { create :conference, :published, promoted: false, organization: organization, hashtag: hashtag_activity }
  let!(:conference_city) { create :conference, :published, promoted: false, organization: organization, hashtag: hashtag_city }
  let!(:conference_international) { create :conference, :published, promoted: false, organization: organization, hashtag: hashtag_international }

  let(:hashtag_activity) { "activitat" }
  let(:hashtag_city) { "ciutat" }
  let(:hashtag_international) { "internacional" }

  let(:conferences) do
    {
      "activity" => conference_activity,
      "city" => conference_city,
      "international" => conference_international
    }
  end

  before do
    switch_to_host(organization.host)
    visit decidim.root_path
    click_link "Conferences"
  end

  shared_examples "checks the conference link" do |type|
    it "shows the #{type} conference link and its content" do
      expected_text = I18n.t("decidim.conferences.custom_conference_types.#{type}")

      within "#conferences-filter" do
        expect(page).to have_link(text: /#{expected_text}/i)
      end

      click_link expected_text

      expect(page).to have_content(conferences[type].title["en"])
      expect(page).to have_css(".card--conference", count: 1)
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

      within "#conferences-grid" do
        expect(page).to have_css(".card__block", count: 3)
      end
      
    end
  end 
end
