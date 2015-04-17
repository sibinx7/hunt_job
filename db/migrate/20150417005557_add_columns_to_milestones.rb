class AddColumnsToMilestones < ActiveRecord::Migration
  def change
    add_column :milestones , :status , :boolean
    add_column :milestones, :percentage , :integer
    add_column :milestones, :request_payment,:boolean
    add_column :milestones, :grant_payment, :boolean
  end
end
