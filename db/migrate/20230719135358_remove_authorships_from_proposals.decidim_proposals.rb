# frozen_string_literal: true
# This migration comes from decidim_proposals (originally 20180529110830)

class RemoveAuthorshipsFromProposals < ActiveRecord::Migration[5.1]
  def change
    change_table :decidim_proposals_proposals, bulk: true
    remove_column :decidim_proposals_proposals, :decidim_user_group_id, :integer
  end
end
