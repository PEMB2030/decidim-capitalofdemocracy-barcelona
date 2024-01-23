# frozen_string_literal: true
# This migration comes from decidim_sortitions (originally 20180103160301)

class AddCancelDataToSortition < ActiveRecord::Migration[5.1]
  def change
    change_table :decidim_module_sortitions_sortitions, bulk: true
    add_column :decidim_module_sortitions_sortitions, :cancelled_by_user_id, :integer
    add_index :decidim_module_sortitions_sortitions, :cancelled_by_user_id
  end
end
