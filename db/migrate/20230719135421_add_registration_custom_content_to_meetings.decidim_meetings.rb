# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20210217124802)

class AddRegistrationCustomContentToMeetings < ActiveRecord::Migration[5.2]
  def change
    change_table :decidim_meetings_meetings, bulk: true
    add_column :decidim_meetings_meetings, :registration_email_custom_content, :jsonb
  end
end
