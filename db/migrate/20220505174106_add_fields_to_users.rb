class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_column :users, :first_name, :string
    add_column :users, :second_name, :string
    add_column :users, :bio, :string
    add_column :users, :gender, :string
  end
end
