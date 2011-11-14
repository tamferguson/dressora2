class AddUserIdToOutfit < ActiveRecord::Migration
  def change
    add_column :outfits, :user_id, :integer
  end
end
