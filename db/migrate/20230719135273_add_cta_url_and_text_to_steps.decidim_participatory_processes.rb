# frozen_string_literal: true
# This migration comes from decidim_participatory_processes (originally 20180926082635)

class AddCtaUrlAndTextToSteps < ActiveRecord::Migration[5.2]
  def change
    change_table :decidim_participatory_process_steps, bulk: true
    add_column :decidim_participatory_process_steps, :cta_path, :string
  end
end
