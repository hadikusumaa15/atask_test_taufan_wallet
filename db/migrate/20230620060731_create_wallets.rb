class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.references :walletable, polymorphic: true, index: true
      t.float :balance, default: 0
      t.string :description
      t.timestamps
    end
  end
end
