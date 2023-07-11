class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :indices
      t.string :identifier
      t.float :last_price
      t.integer :owned_amount
      t.string :category
      t.string :description
      t.timestamps
    end
  end
end
