class CreateUserProjectStatusTable < ActiveRecord::Migration
  def change
    create_table :user_project_details do |t|
      t.integer :user_id
      t.integer :project_completed, :defaul => 0
      t.integer :project_ongoing, :default => 0
      t.integer :project_lost, :default => 0
      t.integer :user_income, :default => 0, :null => false
      t.timestamps
    end
  end
end
