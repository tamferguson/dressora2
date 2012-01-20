class Choice < ActiveRecord::Base
  belongs_to :user
  has_many :outfits
  has_many :items
  has_many :requests
end
