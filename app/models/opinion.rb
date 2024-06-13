class Opinion < ApplicationRecord
  include Notifiable
  
  belongs_to :user
  belongs_to :counseling_room

  has_many :opinion_favorites, dependent: :destroy
  
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :content, presence: true, length: { maximum: 100 }
  
  # データが作成されると直後に通知データも作成される
  after_create do
    records = counseling_room.participations.map do |participation|
      if (participation.user_id != current_user.id) && (participation.status == true)
        notifications.new(user_id: participation.user_id)
      end
    end
    Notification.import records
    notifications.create(user_id: counseling_room.user_id)
  end
  
  # 表示する通知メッセージを取得するメソッド
  def notification_message
    I18n.t('notifications.messages.opinion')
  end
  
  # 通知クリック時のパス先指定のメソッド
  def notification_path
    category_counseling_room_path(counseling_room.category.id, counseling_room.id)
  end
  
  # 対象の意見へ既にいいねしているか確認するメソッド
  def favorited_by?(user)
    opinion_favorites.exists?(user_id: user.id)
  end

end
