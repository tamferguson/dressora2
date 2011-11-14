class Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :outfit
  
  belongs_to :user
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
