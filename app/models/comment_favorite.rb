class CommentFavorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :comment
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  validates :user_id, uniqueness: { scope: :comment_id }
  
  after_create do
    create_notification(user_id: comment.user_id)
  end
  
end
