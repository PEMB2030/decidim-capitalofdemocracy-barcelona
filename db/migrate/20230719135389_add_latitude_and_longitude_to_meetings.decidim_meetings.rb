# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20170123151650)

class AddLatitudeAndLongitudeToMeetings < ActiveRecord::Migration[5.0]
  def change
    change_table :decidim_meetings_meetings, bulk: true
    add_column :decidim_meetings_meetings, :longitude, :float
  end
end
