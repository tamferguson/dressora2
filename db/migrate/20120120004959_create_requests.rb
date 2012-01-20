class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :fb_user_id
      t.integer :choice_id

      t.timestamps
    end
  end
end
