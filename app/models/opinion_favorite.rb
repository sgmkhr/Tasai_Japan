class OpinionFavorite < ApplicationRecord
  include Notifiable
  
  belongs_to :user
  belongs_to :opinion
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  validates :user_id, uniqueness: { scope: :opinion_id }
  
  after_create do
    create_notification(user_id: opinion.user_id)
  end
  
  def notification_message
    user.public_name + I18n.t('notifications.messages.opinion_favorite')
  end
  
  def notification_path
    category_counseling_room_path(opinion.counseling_room.category.id, opinion.counseling_room.id)
  end
  
end
