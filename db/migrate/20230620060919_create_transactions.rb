class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :source_wallet, references: :wallets, index: true
      t.references :target_wallet, references: :wallets, index: true
      t.decimal :amount
      t.string :description
      t.timestamps
    end
  end
end
