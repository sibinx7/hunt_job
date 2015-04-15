class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.integer :user_id
      t.string  :name
      t.text    :address
      t.string  :place
      t.string  :account_no
      t.string  :ifsc_code
      t.string  :card_no
      t.string  :card_csc
      t.timestamps
    end
  end
end
