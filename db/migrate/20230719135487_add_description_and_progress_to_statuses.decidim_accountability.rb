# frozen_string_literal: true
# This migration comes from decidim_accountability (originally 20170508104902)

class AddDescriptionAndProgressToStatuses < ActiveRecord::Migration[5.0]
  def change
    change_table :decidim_accountability_statuses, bulk: true
    add_column :decidim_accountability_statuses, :progress, :integer
  end
end
