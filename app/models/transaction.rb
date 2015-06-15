class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :bank_transaction,:foreign_key => 'bank_account_id',:class_name => 'BankAccount'
end