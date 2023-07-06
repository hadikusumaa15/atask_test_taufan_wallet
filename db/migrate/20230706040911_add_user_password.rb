class AddUserPassword < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password, :string, length: { minimum: 6 }, null: false
  end
end
