# frozen_string_literal: true
# This migration comes from decidim (originally 20211126183540)

class AddTimestampsToContentBlocks < ActiveRecord::Migration[6.0]
  def up
    change_table :decidim_content_blocks, bulk: true
    change_column_default :decidim_content_blocks, :updated_at, nil
  end

  def down
    change_table :decidim_content_blocks, bulk: true
    remove_column :decidim_content_blocks, :created_at
  end
end
