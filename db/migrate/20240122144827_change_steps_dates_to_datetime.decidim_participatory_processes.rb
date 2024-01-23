# frozen_string_literal: true
# This migration comes from decidim_participatory_processes (originally 20220315100140)

class ChangeStepsDatesToDatetime < ActiveRecord::Migration[6.0]
  def change
    change_table :decidim_participatory_process_steps, bulk: true
    change_column :decidim_participatory_process_steps, :end_date, :datetime
  end
end
