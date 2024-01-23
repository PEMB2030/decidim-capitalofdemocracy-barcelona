# frozen_string_literal: true
# This migration comes from decidim (originally 20170914092116)

class RemoveCommentAndRepliesNotificationsFromUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :decidim_users, bulk: true
    remove_column :decidim_users, :replies_notifications
  end
end
