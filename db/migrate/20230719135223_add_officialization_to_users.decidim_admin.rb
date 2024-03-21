# frozen_string_literal: true
# This migration comes from decidim_admin (originally 20171219154507)

class AddOfficializationToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :decidim_users, bulk: true
    add_column :decidim_users, :officialized_as, :jsonb

    add_index :decidim_users, :officialized_at
  end
end
