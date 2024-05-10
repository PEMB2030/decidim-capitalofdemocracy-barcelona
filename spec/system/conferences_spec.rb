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

  context "when speakers" do
    let(:conference) { conference_city }
    let!(:speaker1) { create(:conference_speaker, conference:, position: { en: "Random position" }) }
    let!(:speaker2) { create(:conference_speaker, conference:, position: { en: "Gamer" }) }
    let(:divisor) do
      [{
        name: :participants
      },
       {
         name: :gamers,
         position_filter: "gamer"
       }]
    end

    before do
      allow(Rails.application.secrets.speakers_divisor).to receive(:dig).and_call_original
      allow(Rails.application.secrets.speakers_divisor).to receive(:dig).with(conference_city.slug.to_sym).and_return(divisor)
      visit decidim_conferences.conference_conference_speakers_path(conference_slug: conference.slug)
    end

    it "has separate speakers" do
      within first(".title-decorator") do
        expect(page).to have_content("Participants")
      end
      within first(".conference__speaker__container") do
        expect(page).to have_content(speaker1.full_name)
      end
      within all(".title-decorator").last do
        expect(page).to have_content("Gamers")
      end
      within all(".conference__speaker__container").last do
        expect(page).to have_content(speaker2.full_name)
      end
    end

    context "when no divisor" do
      let(:conference) { conference_activity }

      it "has only one set of speakers" do
        within ".title-decorator" do
          expect(page).to have_content("Speakers")
        end
        within ".conference__speaker__container" do
          expect(page).to have_content(speaker1.full_name)
          expect(page).to have_content(speaker2.full_name)
        end
        expect(page).to have_no_content("Gamers")
      end
    end
  end
end
