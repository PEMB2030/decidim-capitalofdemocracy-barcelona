# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20170110142105)

class CloseAMeeting < ActiveRecord::Migration[5.0]
  def change
    change_table :decidim_meetings_meetings, bulk: true
    add_column :decidim_meetings_meetings, :closed_at, :time
    add_index :decidim_meetings_meetings, :closed_at
  end
end
