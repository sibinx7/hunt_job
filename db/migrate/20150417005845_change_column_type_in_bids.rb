class ChangeColumnTypeInBids < ActiveRecord::Migration
  def change
    change_column :bids , :percentage , :integer
  end
end
