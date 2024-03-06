# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20210519133705)

class AddCommentsAvailabilityColumnsToMeetingsTable < ActiveRecord::Migration[6.0]
  def change
    change_table :decidim_meetings_meetings, bulk: true
    add_column :decidim_meetings_meetings, :comments_end_time, :datetime
    reversible do |dir|
      dir.up do
        execute "UPDATE decidim_meetings_meetings set comments_enabled = true"
      end
    end
  end
end
