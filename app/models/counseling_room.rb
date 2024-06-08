class CounselingRoom < ApplicationRecord

  belongs_to :user
  belongs_to :category

  has_many :participations, dependent: :destroy
  has_many :opinions,       dependent: :destroy

  has_one_attached :topic_image

  validates :topic,  presence: true, length: { maximum: 100 }, uniqueness: { scope: :category }
  validates :detail, presence: true, length: { maximum: 2000 }

  def get_topic_image(width, height)
    topic_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def self.search_with_category_for(content, category)
    counseling_rooms = CounselingRoom.where(category_id: category.id)
    return counseling_rooms if content == ''
    counseling_rooms.where(['topic LIKE(?) OR detail LIKE(?)', "%#{content}%", "%#{content}%"])
  end

end
