class RoomTag < ApplicationRecord
  
  has_many :related_room_tags, dependent: :destroy
  
  has_many :counseling_rooms, through: :related_room_tags
  
  validates :name, presence: true, uniqueness: true
  
  #紐付いた相談室の多い順に並べ替えるメソッド
  def self.sort_by_popularity
    RoomTag.all.sort_by { |tag| -tag.related_room_tags.count }
  end
  
end
