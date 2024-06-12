class Relationship < ApplicationRecord
  include Notifiable
  
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  # データが作成されると直後に通知データも作成される
  after_create do
    create_notification(user_id: followed_id)
  end
  
  # 表示する通知メッセージを取得するメソッド
  def notification_message
    follower.canonical_name + I18n.t('notifications.messages.relationship')
  end
  
  # 通知クリック時のパス先指定のメソッド
  def notification_path
    user_path(follower.canonical_name)
  end
  
end
