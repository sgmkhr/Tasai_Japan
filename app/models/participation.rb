class Participation < ApplicationRecord
  include Notifiable

  belongs_to :counseling_room
  belongs_to :user

  has_one :notification, as: :notifiable, dependent: :destroy

  # データが作成されると直後に通知データも作成される
  after_create do
    create_notification(user_id: counseling_room.user_id)
  end

  # 表示する通知メッセージを取得するメソッド
  def notification_message
    '「' + counseling_room.topic + '」' + I18n.t('notifications.messages.participation.for_creator')
  end

  # 通知クリック時のパス先指定のメソッド
  def notification_path
    category_counseling_room_path(counseling_room.category.id, counseling_room.id)
  end

end
