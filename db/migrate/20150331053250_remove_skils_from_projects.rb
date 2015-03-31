class RemoveSkilsFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :skills
  end
end
