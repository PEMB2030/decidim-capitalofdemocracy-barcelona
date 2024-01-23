# frozen_string_literal: true
# This migration comes from decidim_templates (originally 20221006055954)

class AddFieldValuesAndTargetToDecidimTemplates < ActiveRecord::Migration[6.0]
  class Template < ApplicationRecord
    self.table_name = :decidim_templates_templates
  end

  def change
    change_table :decidim_templates_templates, bulk: true
    add_column :decidim_templates_templates, :target, :string

    reversible do |direction|
      direction.up do
        # rubocop:disable Rails/SkipsModelValidations
        Template.where(templatable_type: "Decidim::Forms::Questionnaire").update_all(target: "questionnaire")
        Template.where(templatable_type: "Decidim::Organization").update_all(target: "user_block")
        # rubocop:enable Rails/SkipsModelValidations
      end
    end
  end
end
