# frozen_string_literal: true
# This migration comes from decidim_proposals (originally 20200210135152)

class AddCostsToProposals < ActiveRecord::Migration[5.2]
  def change
    change_table :decidim_proposals_proposals, bulk: true
    add_column :decidim_proposals_proposals, :execution_period, :jsonb
  end
end
