class PostFavorite < ApplicationRecord
  include Notifiable
  
  belongs_to :user
  belongs_to :post
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  validates :user_id, uniqueness: { scope: :post_id }
  
  # データが作成されると直後に通知データも作成される
  after_create do
    create_notification(user_id: post.user_id)
  end
  
  # 表示する通知メッセージを取得するメソッド
  def notification_message
    I18n.t('notifications.messages.post_favorite', public_name: user.public_name, title: post.title)
  end
  
  # 通知クリック時のパス先指定のメソッド
  def notification_path(locale_params)
    post_path(post.id, locale: locale_params)
  end
  
end
