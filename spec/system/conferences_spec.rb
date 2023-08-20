# frozen_string_literal: true

require "rails_helper"

describe "Visit conferences", type: :system do
  let!(:organization) { create :organization }
  let!(:conference_city) { create :conference, :published, :promoted, organization: organization, hashtag: hashtag_city }
  let!(:conference_global) { create :conference, :published, :promoted, organization: organization, hashtag: hashtag_global }
  let!(:conference_parallel) { create :conference, :published, :promoted, organization: organization, hashtag: hashtag_parallel }
  let(:hashtag_global) { "actesglobals" }
  let(:hashtag_parallel) { "actesparalels" }

  before do
    switch_to_host(organization.host)
  end

  context "when visiting home page" do
    let!(:hashtag_city) { "actesciutat" }

    before do
      visit decidim.root_path
    end

    it "shows the original conference menu" do
      within ".main-nav" do
        expect(page).to have_content("Conferences")
        expect(page).to have_link(href: "/conferences")
      end
    end

    it "shows the city conference menu" do
      within ".main-nav" do
        expect(page).to have_content("City conferences")
        expect(page).to have_link(href: "/conferences/city")
      end

      click_link "City conferences"

      expect(page).to have_content("1 CONFERENCE")
      expect(page).to have_content(conference_city.title["en"], count: 2)
      expect(page).not_to have_content(conference_global.title["en"])
      expect(page).not_to have_content(conference_parallel.title["en"])
    end

    it "shows the global conference menu" do
      within ".main-nav" do
        expect(page).to have_content("Conferences")
        expect(page).to have_link(href: "/conferences")
      end

      click_link "Conferences"

      expect(page).to have_content("1 CONFERENCE")
      expect(page).to have_content(conference_global.title["en"], count: 2)
      expect(page).not_to have_content(conference_city.title["en"])
      expect(page).not_to have_content(conference_parallel.title["en"])
    end

    it "shows the parallel conference menu" do
      within ".main-nav" do
        expect(page).to have_content("Parallel conferences")
        expect(page).to have_link(href: "/conferences/parallel")
      end

      click_link "Parallel conferences"

      expect(page).to have_content("1 CONFERENCE")
      expect(page).to have_content(conference_parallel.title["en"], count: 2)
      expect(page).not_to have_content(conference_city.title["en"])
      expect(page).not_to have_content(conference_global.title["en"])
    end
  end

  context "when hashtag with #" do
    let!(:hashtag_city) { "#actesciutat" }

    before do
      visit decidim.root_path
    end

    it "shows the city conference menu" do
      within ".main-nav" do
        expect(page).to have_content("City conferences")
        expect(page).to have_link(href: "/conferences/city")
      end

      click_link "City conferences"

      expect(page).to have_content("1 CONFERENCE")
    end
  end

  context "when hashtag contains spaces" do
    let!(:hashtag_city) { " actesciutat " }

    before do
      visit decidim.root_path
    end

    it "shows the city conference menu" do
      within ".main-nav" do
        expect(page).to have_content("City conferences")
        expect(page).to have_link(href: "/conferences/city")
      end

      click_link "City conferences"

      expect(page).to have_content("1 CONFERENCE")
      expect(page).to have_content(conference_city.title["en"])
      expect(page).not_to have_content(conference_global.title["en"])
      expect(page).not_to have_content(conference_parallel.title["en"])
    end
  end
end
