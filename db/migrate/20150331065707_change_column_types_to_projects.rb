class ChangeColumnTypesToProjects < ActiveRecord::Migration
  def change
    change_column :projects, :creator, :string
    change_column :projects, :assigned_to, :string
  end
end
