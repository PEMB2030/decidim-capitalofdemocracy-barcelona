# frozen_string_literal: true

require "rails_helper"

module Decidim::Conferences
  describe ConferenceSort do
    let(:organization) { create(:organization) }
    let(:upcoming_conference_one) { create(:conference, :published, promoted: false, organization: organization, start_date: 1.week.from_now, end_date: 2.weeks.from_now) }
    let(:upcoming_conference_two) { create(:conference, :published, promoted: false, organization: organization, start_date: 2.weeks.from_now, end_date: 3.weeks.from_now) }
    let(:past_conference_one) { create(:conference, :published, promoted: false, organization: organization, start_date: 2.months.ago, end_date: 1.month.ago) }
    let(:past_conference_two) { create(:conference, :published, promoted: false, organization: organization, start_date: 3.months.ago, end_date: 2.months.ago) }

    let(:conferences) do
      [
        past_conference_two,
        upcoming_conference_two,
        past_conference_one,
        upcoming_conference_one
      ]
    end

    describe "#sort" do
      subject { described_class.new(conferences).sort }

      it "returns meetings in expected order" do
        expect(subject).to eq([
                                upcoming_conference_one,
                                upcoming_conference_two,
                                past_conference_two,
                                past_conference_one
                              ])
      end
    end
  end
end
