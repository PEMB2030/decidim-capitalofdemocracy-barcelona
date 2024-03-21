# frozen_string_literal: true
# This migration comes from decidim (originally 20161006085629)

class AddConfirmableToDevise < ActiveRecord::Migration[5.0]
  def up
    change_table :decidim_users, bulk: true
    add_column :decidim_users, :unconfirmed_email, :string
    add_index :decidim_users, :confirmation_token, unique: true
    execute("UPDATE decidim_users SET confirmed_at = NOW()")
  end

  def down
    remove_columns :decidim_users, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
