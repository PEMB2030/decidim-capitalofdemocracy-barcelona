# frozen_string_literal: true
# This migration comes from decidim (originally 20220518094535)

class AddPreviousPasswordsToUsers < ActiveRecord::Migration[6.1]
  class User < ApplicationRecord
    self.table_name = :decidim_users
  end

  def change
    change_table :decidim_users, bulk: true
    add_column :decidim_users, :previous_passwords, :string, array: true, default: []

    reversible do |direction|
      direction.up do
        # rubocop:disable Rails/SkipsModelValidations
        User.update_all("password_updated_at = updated_at")
        # rubocop:enable Rails/SkipsModelValidations
      end
    end
  end
end
