class Participation < ApplicationRecord
  include Notifiable

  belongs_to :counseling_room
  belongs_to :user
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  after_create do
    create_notification(user_id: counseling_room.user_id)
  end
  
  def notification_message
    I18n.t('notifications.messages.participation')
  end
  
  def notification_path
    edit_category_counseling_room_path(counseling_room.category.id, counseling_room.id)
  end

end
