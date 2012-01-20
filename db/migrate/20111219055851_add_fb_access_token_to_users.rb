class AddFbAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_access_token, :string
    add_column :users, :fb_uid, :integer
  end
end
