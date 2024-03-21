# frozen_string_literal: true
# This migration comes from decidim (originally 20180611121852)

class ChangeNewsletterNotificationTypeValue < ActiveRecord::Migration[5.2]
  class User < ApplicationRecord
    self.table_name = :decidim_users
  end

  def up
    change_table :decidim_users, bulk: true
    add_column :decidim_users, :newsletter_notifications_at, :datetime
    User.reset_column_information
    User.where(newsletter_notifications: true).update(newsletter_notifications_at: Time.zone.parse("2018-05-24 00:00 +02:00"))
    remove_column :decidim_users, :newsletter_notifications
  end

  def down
    add_column :decidim_users, :newsletter_notifications, :boolean, default: false, null: false
    User.reset_column_information
    User.where.not(newsletter_notifications_at: nil).update(newsletter_notifications: true)
    change_table :decidim_users, bulk: true
    remove_column :decidim_users, :newsletter_token
  end
end
