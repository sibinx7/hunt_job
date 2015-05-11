class AddClientFeedbackColumnsInBid < ActiveRecord::Migration
  def change
    add_column :bids, :client_feedback, :text
  end
end
