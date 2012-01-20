class CreateEventsOutfits < ActiveRecord::Migration
  def change
    create_table :events_outfits do |t|
      t.integer :event_id
      t.integer :outfit_id

      t.timestamps
    end
  end
end
