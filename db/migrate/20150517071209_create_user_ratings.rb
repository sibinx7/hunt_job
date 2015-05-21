class CreateUserRatings < ActiveRecord::Migration
  def change
    create_table :user_ratings do |t|
      t.integer :user_id
      t.text :description
      t.integer :rating
      t.integer :rated_by
      t.integer :project_id

      t.timestamps
    end
  end
end
