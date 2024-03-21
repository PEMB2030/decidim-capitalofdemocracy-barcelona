# frozen_string_literal: true
# This migration comes from decidim (originally 20180115090038)

class ExtendUserProfile < ActiveRecord::Migration[5.1]
  def change
    change_table :decidim_users, bulk: true
    add_column :decidim_users, :about, :text
  end
end
