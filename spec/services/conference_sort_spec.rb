# frozen_string_literal: true

require "rails_helper"

module Decidim::Conferences
  describe ConferenceSort do
    let(:organization) { create(:organization) }
    let(:upcoming_conference_one) { create(:conference, :published, promoted: false, id: past_conference_one.id * 10, organization:, start_date: 1.week.from_now, end_date: 2.weeks.from_now) }
    let(:upcoming_conference_two) { create(:conference, :published, promoted: false, organization:, start_date: 2.weeks.from_now, end_date: 3.weeks.from_now) }
    let(:upcoming_conference_three) { create(:conference, :published, promoted: false, id: past_conference_two.id * 10, organization:, start_date: 1.day.ago, end_date: 1.day.from_now) }
    let(:conference_today) { create(:conference, :published, promoted: false, id: past_conference_three.id * 10, organization:, start_date: Date.current, end_date: Date.current) }
    let(:past_conference_one) { create(:conference, :published, promoted: false, organization:, start_date: 2.months.ago, end_date: 1.month.ago) }
    let(:past_conference_two) { create(:conference, :published, promoted: false, organization:, start_date: 3.months.ago, end_date: 2.months.ago) }
    let(:past_conference_three) { create(:conference, :published, promoted: false, organization:, start_date: 3.days.ago, end_date: 1.day.ago) }

    let(:conferences) do
      [
        past_conference_two,
        upcoming_conference_two,
        upcoming_conference_three,
        past_conference_one,
        upcoming_conference_one,
        past_conference_three,
        conference_today
      ]
    end

    describe "#sort" do
      subject { described_class.new(conferences).sort }

      it "returns meetings in expected order" do
        expect(subject).to eq([
                                upcoming_conference_three,
                                conference_today,
                                upcoming_conference_one,
                                upcoming_conference_two,
                                past_conference_three,
                                past_conference_one,
                                past_conference_two
                              ])
      end
    end
  end
end
