class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, :after => :id
    add_column :users, :username, :string, :after => :name
    add_column :users, :country, :string, :after => :username
  end
end
