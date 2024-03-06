# frozen_string_literal: true
# This migration comes from decidim_proposals (originally 20170228105156)

class AddGeolocalizationFieldsToProposals < ActiveRecord::Migration[5.0]
  def change
    change_table :decidim_proposals_proposals, bulk: true
    add_column :decidim_proposals_proposals, :longitude, :float
  end
end
