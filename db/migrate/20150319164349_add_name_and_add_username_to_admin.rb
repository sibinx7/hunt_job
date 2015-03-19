class AddNameAndAddUsernameToAdmin < ActiveRecord::Migration
  def up
    add_column :admins, :name, :string, after:'id'
    add_column :admins, :username, :string, after:'name'

  end
  def down
    remove_column :admins, :name
    remove_column :admins, :username
  end
end
