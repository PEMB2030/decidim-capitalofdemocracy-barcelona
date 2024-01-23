# frozen_string_literal: true
# This migration comes from decidim_participatory_processes (originally 20170206083118)

class RenameExtraInfoOnProcesses < ActiveRecord::Migration[5.0]
  def change
    remove_column :decidim_participatory_processes, :developer_group

    rename_column :decidim_participatory_processes, :domain, :developer_group

    change_table :decidim_participatory_processes, bulk: true
    add_column :decidim_participatory_processes, :participatory_structure, :jsonb
  end
end
