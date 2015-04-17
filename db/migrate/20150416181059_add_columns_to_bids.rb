class AddColumnsToBids < ActiveRecord::Migration
  def change
    add_column :bids , :status , :boolean
    add_column :bids , :percentage , :boolean
    add_column :bids, :granted , :boolean
    add_column :bids , :accepted , :boolean
  end
end
