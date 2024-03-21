# frozen_string_literal: true
# This migration comes from decidim (originally 20170605140421)

class AddDeletedFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :decidim_users, bulk: true
    add_column :decidim_users, :deleted_at, :datetime
  end
end
