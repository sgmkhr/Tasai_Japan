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
    I18n.t('notifications.messages.relationship', canonical_name: follower.canonical_name)
  end
  
  # 通知クリック時のパス先指定のメソッド
  def notification_path(locale_params)
    user_path(follower.canonical_name, locale: locale_params)
  end
  
end
