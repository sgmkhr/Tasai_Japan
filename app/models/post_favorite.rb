class PostFavorite < ApplicationRecord
  include Notifiable
  
  belongs_to :user
  belongs_to :post
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  validates :user_id, uniqueness: { scope: :post_id }
  
  after_create do
    create_notification(user_id: post.user_id)
  end
  
  def notification_message
    I18n.t('notifications.messages.post_favorite')
  end
  
  def notification_path
    post_path(post.id)
  end
  
end
