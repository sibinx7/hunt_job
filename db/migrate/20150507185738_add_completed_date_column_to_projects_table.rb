class AddCompletedDateColumnToProjectsTable < ActiveRecord::Migration
  def change
    add_column :projects, :completed_date , :datetime
  end
end
