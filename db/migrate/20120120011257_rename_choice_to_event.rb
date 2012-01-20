class RenameChoiceToEvent < ActiveRecord::Migration
  def up
    rename_column :requests, :choice_id, :event_id
  end

  def down
  end
end
