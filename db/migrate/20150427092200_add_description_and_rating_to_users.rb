class AddDescriptionAndRatingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_info , :text
    add_column :users, :user_rating, :integer
  end
end
