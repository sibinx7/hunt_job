class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :title
      t.text :description
      t.integer :creator
      t.string :service_image
      t.string :service_link

      t.timestamps
    end
  end
end
