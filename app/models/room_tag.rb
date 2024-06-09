class RoomTag < ApplicationRecord
  
  has_many :related_room_tags, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  
end
