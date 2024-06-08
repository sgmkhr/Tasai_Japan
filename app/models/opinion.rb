class Opinion < ApplicationRecord
  belongs_to :user
  belongs_to :counseling_room

  has_many :opinion_favorites, dependent: :destroy

  validates :content, presence: true, length: { maximum: 100 }

  def favorited_by?(user)
    opinion_favorites.exists?(user_id: user.id)
  end

end
