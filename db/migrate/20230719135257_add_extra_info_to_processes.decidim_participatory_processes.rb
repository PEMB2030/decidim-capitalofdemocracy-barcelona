# frozen_string_literal: true
# This migration comes from decidim_participatory_processes (originally 20170126151123)

class AddExtraInfoToProcesses < ActiveRecord::Migration[5.0]
  def change
    change_table :decidim_participatory_processes, bulk: true
    add_column :decidim_participatory_processes, :scope, :jsonb
  end
end
