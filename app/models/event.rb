class Event < ActiveRecord::Base
  belongs_to :user
  has_many :requests
  has_many :events_outfits
  has_many :outfits, :through => :events_outfits
end
