# frozen_string_literal: true
# This migration comes from decidim (originally 20170207093048)

class AddOrganizationLogoAndUrl < ActiveRecord::Migration[5.0]
  def change
    change_table :decidim_organizations, bulk: true
    add_column :decidim_organizations, :official_url, :string
  end
end
