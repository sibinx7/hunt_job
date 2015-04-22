class AddAcceptedDateToBids < ActiveRecord::Migration
  def change
    add_column :bids, :accepted_date, :datetime
  end
end
