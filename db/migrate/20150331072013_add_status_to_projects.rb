class AddStatusToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :status, :string
    add_column :projects, :close, :boolean
  end
end
