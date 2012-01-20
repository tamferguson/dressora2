class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :title
      t.datetime :event_datetime

      t.timestamps
    end
  end
end
