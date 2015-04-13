class CreateBidsTable < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.text :details
      t.integer :project_id
      t.integer :user_id
      t.integer :bid
      t.integer :duration
    end
  end
end
