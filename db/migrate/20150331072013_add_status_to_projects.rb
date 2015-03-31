class AddStatusToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :status, :boolean
    add_column :projects, :close, :boolean
  end
end
