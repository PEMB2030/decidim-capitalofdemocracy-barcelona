# frozen_string_literal: true
# This migration comes from decidim (originally 20210412120115)

class AddEnableParticipatorySpaceFiltersToOrganization < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations, :enable_participatory_space_filters, :boolean, default: true, null: false
  end
end
