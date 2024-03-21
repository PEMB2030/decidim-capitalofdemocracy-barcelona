# frozen_string_literal: true
# This migration comes from decidim_assemblies (originally 20200416132109)

class RemoveLegacyDecidimAssemblyType < ActiveRecord::Migration[5.2]
  def change
    change_table :decidim_assemblies, bulk: true
    remove_column :decidim_assemblies, :assembly_type_other, :jsonb
  end
end
