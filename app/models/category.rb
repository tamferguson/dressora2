class Category < ActiveRecord::Base
  has_many :items
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
