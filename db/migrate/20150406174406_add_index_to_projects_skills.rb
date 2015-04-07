class AddIndexToProjectsSkills < ActiveRecord::Migration
  def change
    add_index :projects_skills , [:project_id,:skill_id]
  end
end
