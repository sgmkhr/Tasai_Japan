class Participation < ApplicationRecord

  belongs_to :counseling_room
  belongs_to :user
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  after_create do
    create_notification(user_id: counseling_room.user_id)
  end

end
