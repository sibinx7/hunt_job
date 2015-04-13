class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.string :milestone
      t.integer :bid_id
      t.integer :payment
    end
  end
end
