# frozen_string_literal: true
# This migration comes from decidim (originally 20191028135718)

class AddLockableToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :decidim_users, bulk: true
    add_column :decidim_users, :locked_at, :datetime
    add_index :decidim_users, :unlock_token, unique: true
  end
end
