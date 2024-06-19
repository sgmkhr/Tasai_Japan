class Opinion < ApplicationRecord
  include Notifiable

  belongs_to :user
  belongs_to :counseling_room

  has_many :opinion_favorites, dependent: :destroy

  has_many :notifications, as: :notifiable, dependent: :destroy

  scope :created_days_ago, ->(n) { where(created_at: n.days.ago.all_day) }

  validates :content, presence: true, length: { maximum: 1000 }

  # データが作成されると直後に通知データも作成される
  after_create do
    participations = counseling_room.participations.where(status: true)
    if participations.count >= 2 #意見投稿者以外にも参加者がいる場合のみ実行
      records = counseling_room.participations.map do |participation|
        next if (user_id == participation.user_id) || (participation.status == false)
        notifications.new(user_id: participation.user_id)
      end.compact
      Notification.import records
    end
    notifications.create(user_id: counseling_room.user_id)
  end

  # 表示する通知メッセージを取得するメソッド
  def notification_message
    I18n.t('notifications.messages.opinion', topic: counseling_room.topic)
  end

  # 通知クリック時のパス先指定のメソッド
  def notification_path
    category_counseling_room_path(counseling_room.category.id, counseling_room.id)
  end

  # 対象の意見へ既にいいねしているか確認するメソッド
  def favorited_by?(user)
    opinion_favorites.exists?(user_id: user.id)
  end

  # 過去１週間の各日の意見数データを取得するメソッド
  def self.past_week_count
   (0..6).map { |n| created_days_ago(n).count }.reverse
  end

end
