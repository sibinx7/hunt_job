class ChangeDurationToCloseDateInProjects < ActiveRecord::Migration
  def change
    rename_column :projects, :duration, :close_date
  end
end
