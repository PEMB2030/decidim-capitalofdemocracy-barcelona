# frozen_string_literal: true
# This migration comes from decidim_participatory_processes (originally 20201008154315)

class AddMetadataColumnsToParticipatoryProcessGroups < ActiveRecord::Migration[5.2]
  def change
    change_table :decidim_participatory_process_groups, bulk: true
    add_column :decidim_participatory_process_groups, :participatory_structure, :jsonb
  end
end
