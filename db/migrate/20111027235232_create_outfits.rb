class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
      t.integer :accessory_id
      t.integer :top_id
      t.integer :bottom_id
      t.integer :shoes_id

      t.timestamps
    end
  end
end
