# frozen_string_literal: true
# This migration comes from decidim (originally 20181115102958)

class AddFollowingAndFollowersCountersToUsers < ActiveRecord::Migration[5.2]
  def up
    change_table :decidim_users, bulk: true
    add_column :decidim_users, :followers_count, :integer, null: false, default: 0
  end

  def down
    change_table :decidim_users, bulk: true
    remove_column :decidim_users, :followers_count
  end
end
