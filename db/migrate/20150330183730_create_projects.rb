class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :creator
      t.integer :skills
      t.integer :min_budget
      t.integer :max_budget
      t.date :duration
      t.integer :assigned_to

      t.timestamps
    end
  end
end
