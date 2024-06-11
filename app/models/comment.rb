class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  has_many :comment_favorites, dependent: :destroy
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  validates :content, presence: true, length: { maximum: 50 }
  
  after_create do
    create_notification(user_id: post.user_id)
  end
  
  def favorited_by?(user)
    comment_favorites.exists?(user_id: user.id)
  end
  
end
