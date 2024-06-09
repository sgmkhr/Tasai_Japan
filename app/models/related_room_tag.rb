class RelatedRoomTag < ApplicationRecord
  
  belongs_to :counseling_room
  belongs_to :room_tag
  
end
