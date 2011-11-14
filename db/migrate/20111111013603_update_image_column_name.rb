class UpdateImageColumnName < ActiveRecord::Migration
  def up
    rename_column :items, :image, :image_file_name 
  end

  def down
    rename_column :items, :image_file_name, :image 
  end
end
