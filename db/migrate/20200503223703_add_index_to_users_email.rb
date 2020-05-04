# frozen_string_literal: true

class AddIndexToUsersEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :email, unique: true
    # Ex:- add_index("admin_users", "username")
  end
end
