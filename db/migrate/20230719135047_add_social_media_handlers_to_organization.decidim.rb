# frozen_string_literal: true
# This migration comes from decidim (originally 20170207091021)

class AddSocialMediaHandlersToOrganization < ActiveRecord::Migration[5.0]
  def change
    change_table :decidim_organizations, bulk: true
    add_column :decidim_organizations, :github_handler, :string
  end
end
