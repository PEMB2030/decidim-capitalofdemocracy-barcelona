# frozen_string_literal: true
# This migration comes from decidim_participatory_processes (originally 20180122110007)

class AddPrivateToParticipatoryProcesses < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_participatory_processes, :private_space, :boolean, default: false, null: false
  end
end
