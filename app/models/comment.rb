class Comment < ApplicationRecord
  include Notifiable
  
  belongs_to :user
  belongs_to :post
  
  has_many :comment_favorites, dependent: :destroy
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  validates :content, presence: true, length: { maximum: 50 }
  
  # データが作成されると直後に通知データも作成される
  after_create do
    create_notification(user_id: post.user_id)
  end
  
  # 表示する通知メッセージを取得するメソッド
  def notification_message
    '「' + post.title + '」' + I18n.t('notifications.messages.comment')
  end
  
  # 通知クリック時のパス先指定のメソッド
  def notification_path
    post_path(post_id)
  end
  
  # 対象のコメントへ既にいいねしているか確認するメソッド
  def favorited_by?(user)
    comment_favorites.exists?(user_id: user.id)
  end
  
end
