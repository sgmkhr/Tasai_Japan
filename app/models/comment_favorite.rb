class CommentFavorite < ApplicationRecord
  include Notifiable
  
  belongs_to :user
  belongs_to :comment
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  validates :user_id, uniqueness: { scope: :comment_id }
  
  after_create do
    create_notification(user_id: comment.user_id)
  end
  
  def notification_message
    I18n.t('notifications.messages.comment_favorite')
  end
  
  def notification_path
    post_path(comment.post.id)
  end
  
end
