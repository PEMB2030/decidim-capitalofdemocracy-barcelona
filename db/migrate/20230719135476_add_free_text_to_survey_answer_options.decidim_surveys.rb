# frozen_string_literal: true
# This migration comes from decidim_surveys (originally 20180405015258)

class AddFreeTextToSurveyAnswerOptions < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_surveys_survey_answer_options, :free_text, :boolean, default: false, null: false
  end
end
