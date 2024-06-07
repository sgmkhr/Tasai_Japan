class Category < ApplicationRecord

  has_many :counseling_rooms, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.search_for(content)
    return Category.all if content == ''
    categories = Category.where('name LIKE(?)', '%#{content}%')
    counseling_rooms = CounselingRoom.where(['topic LIKE(?) OR detail LIKE(?)', "%#{content}%", "%#{content}%"])
    if counseling_rooms
      counseling_rooms.each do |counseling_room|
        if categories.exists?(id: counseling_room.category_id)
          categories << counseling_room.category
        end
      end
    end
    return categories
  end

  def self.search_counseling_rooms_for(content, category)
    counseling_rooms = CounselingRoom.where(category_id: category.id)
    return counseling_rooms if content == ''
    counseling_rooms.where(['topic LIKE(?) OR detail LIKE(?)', "%#{content}%", "%#{content}%"])
  end

end
