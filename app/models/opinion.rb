class Opinion < ApplicationRecord
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

  def favorited_by?(user)
    opinion_favorites.exists?(user_id: user.id)
  end

end
