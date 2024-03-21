# frozen_string_literal: true
# This migration comes from decidim (originally 20170202084913)

class AddCommentsAndRepliesNotificationsToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :decidim_users, bulk: true
    add_column :decidim_users, :replies_notifications, :boolean, null: false, default: false
  end
end
