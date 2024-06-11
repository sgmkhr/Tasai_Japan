class Relationship < ApplicationRecord
  include Notifiable
  
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  after_create do
    create_notification(user_id: followed_id)
  end
  
  def notification_message
    follower.canonical_name + I18n.t('notifications.messages.relationship')
  end
  
  def notification_path
    user_path(follower.canonical_name)
  end
  
end
