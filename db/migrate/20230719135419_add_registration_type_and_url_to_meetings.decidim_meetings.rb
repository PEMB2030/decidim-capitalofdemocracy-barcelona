# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20201016112641)

class AddRegistrationTypeAndUrlToMeetings < ActiveRecord::Migration[5.2]
  class Meetings < ApplicationRecord
    self.table_name = :decidim_meetings_meetings
    include Decidim::HasComponent
  end

  def change
    change_table :decidim_meetings_meetings, bulk: true
    add_column :decidim_meetings_meetings, :registration_url, :string

    Meetings.reset_column_information
    Meetings.find_each do |meeting|
      meeting.registration_type = "on_this_platform" if meeting.decidim_author_type == "Decidim::Organization"
      meeting.save!
    end
  end
end
