# frozen_string_literal: true
# This migration comes from decidim (originally 20201010224433)

class AddSuspensionFieldsToDecidimUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :decidim_users, bulk: true
    add_column :decidim_users, :suspended_at, :datetime
  end
end
