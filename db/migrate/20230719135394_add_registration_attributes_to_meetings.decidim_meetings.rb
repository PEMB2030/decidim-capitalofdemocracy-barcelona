# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20170810120836)

class AddRegistrationAttributesToMeetings < ActiveRecord::Migration[5.1]
  def change
    change_table :decidim_meetings_meetings, bulk: true
    add_column :decidim_meetings_meetings, :registration_terms, :jsonb
  end
end
