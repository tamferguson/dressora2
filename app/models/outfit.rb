class Outfit < ActiveRecord::Base
  has_many :accessory, :class_name => 'Item', :foreign_key => 'accessory_id'
  has_many :top, :class_name => 'Item', :foreign_key => 'top_id'
  has_many :bottom, :class_name => 'Item', :foreign_key => 'bottom_id'
  has_many :shoes, :class_name => 'Item', :foreign_key => 'shoes_id'
  belongs_to :user
  has_many :events_outfits
  has_many :events, :through => :events_outfits
end
