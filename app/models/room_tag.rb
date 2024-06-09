class RoomTag < ApplicationRecord
  
  has_many :related_room_tags, dependent: :destroy
  
  has_many :counseling_rooms, through: :related_room_tags
  
  validates :name, presence: true, uniqueness: true
  
end
