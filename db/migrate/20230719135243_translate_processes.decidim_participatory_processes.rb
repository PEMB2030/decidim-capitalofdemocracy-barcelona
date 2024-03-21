# frozen_string_literal: true
# This migration comes from decidim_participatory_processes (originally 20161010102356)

class TranslateProcesses < ActiveRecord::Migration[5.0]
  def change
    change_table :decidim_participatory_processes, bulk: true
    remove_column :decidim_participatory_processes, :short_description

    change_table :decidim_participatory_processes do |t|
      t.jsonb :title, null: false
      t.jsonb :subtitle, null: false
      t.jsonb :short_description, null: false
      t.jsonb :description, null: false
    end
  end
end
