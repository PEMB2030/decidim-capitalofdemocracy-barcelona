# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20180403145218)

class AddMeetingTypes < ActiveRecord::Migration[5.1]
  def change
    change_table :decidim_meetings_meetings, bulk: true
    add_column :decidim_meetings_meetings, :transparent, :boolean, default: true, null: false
  end
end
