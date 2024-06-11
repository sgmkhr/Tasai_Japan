class Opinion < ApplicationRecord
  include Notifiable
  
  belongs_to :user
  belongs_to :counseling_room

  has_many :opinion_favorites, dependent: :destroy
  
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :content, presence: true, length: { maximum: 100 }
  
  after_create do
    records = counseling_room.participations.map do |participation|
      if (participation.user_id != current_user.id) && (participation.status == true)
        notifications.new(user_id: participation.user_id)
      end
    end
    Notification.import records
    create_notification(user_id: counseling_room.user_id)
  end
  
  def notification_message
    if current_user.id == counseling_room.user_id
      user.public_name + I18n.t('notifications.messages.opinion.for_room_creator')
    else
      I18n.t('notifications.messages.opinion.for_participations')
    end
  end
  
  def notification_path
    category_counseling_room_path(counseling_room.category.id, counseling_room.id)
  end

  def favorited_by?(user)
    opinion_favorites.exists?(user_id: user.id)
  end

end
