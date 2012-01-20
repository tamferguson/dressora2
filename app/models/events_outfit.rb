class EventsOutfit < ActiveRecord::Base
  belongs_to :event
  belongs_to :outfit
end
