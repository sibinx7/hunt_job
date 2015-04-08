class RemoveImageProfileFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :profile_image
    add_attachment :users, :profile_image
  end
end
