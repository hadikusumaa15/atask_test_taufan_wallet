class AddUserColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password, :string, length: { minimum: 6 }, null: false
    add_column :users, :access_token_expired_date, :datetime
    add_column :users, :is_team_admin, :boolean, default: false
    add_reference :users, :team, index: true
  end
end
