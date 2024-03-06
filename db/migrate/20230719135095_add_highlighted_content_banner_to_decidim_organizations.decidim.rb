# frozen_string_literal: true
# This migration comes from decidim (originally 20180125063433)

class AddHighlightedContentBannerToDecidimOrganizations < ActiveRecord::Migration[5.1]
  def change
    change_table :decidim_organizations, bulk: true
    add_column :decidim_organizations, :highlighted_content_banner_image, :string
  end
end
