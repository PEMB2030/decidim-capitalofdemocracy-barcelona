# frozen_string_literal: true
# This migration comes from decidim (originally 20210310120640)

class AddFollowableCounterCacheToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :follows_count, :integer, null: false, default: 0
    add_index :decidim_users, :follows_count

    reversible do |dir|
      dir.up do
        Decidim::User.reset_column_information
        Decidim::User.find_each do |record|
          record.class.reset_counters(record.id, :follows)
        end
      end
    end
  end
end
