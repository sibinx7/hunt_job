class CreateTransactionTable < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :bank_account_id
      t.integer :amount
      t.integer :transaction_id
      t.string  :transaction_type
      t.timestamps
    end
  end
end
