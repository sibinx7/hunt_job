class BankAccount < ActiveRecord::Base
  belongs_to :user
  has_many :bank_transaction,:foreign_key => 'bank_account_id',:class_name => 'Transaction'
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :place
  validates_presence_of :ifsc_code
  validates_presence_of :account_no
  validates_presence_of :card_csc
  validates_presence_of :card_no
end
