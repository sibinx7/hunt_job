class CreatePaymentTable < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :sender
      t.integer :receiver
      t.integer :project_id
      t.integer :bid_id
      t.integer :milestone_id
      t.integer :payment
      t.timestamps
    end
  end
end
