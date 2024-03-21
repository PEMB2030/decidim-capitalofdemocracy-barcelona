# frozen_string_literal: true
# This migration comes from decidim_assemblies (originally 20180302121116)

class AddFieldsToAssemblies < ActiveRecord::Migration[5.1]
  def change
    change_table :decidim_assemblies, bulk: true
    add_column :decidim_assemblies, :github_handler, :string
  end
end
