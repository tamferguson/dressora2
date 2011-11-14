class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :type_id
      t.string :brand
      t.string :description
      t.string :size
      t.string :color
      t.string :image

      t.timestamps
    end
  end
end
