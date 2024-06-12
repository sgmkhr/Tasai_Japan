class CommentFavorite < ApplicationRecord
  include Notifiable
  
  belongs_to :user
  belongs_to :comment
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  validates :user_id, uniqueness: { scope: :comment_id }
  
  # データが作成されると直後に通知データも作成される
  after_create do
    create_notification(user_id: comment.user_id)
  end
  
  # 表示する通知メッセージを取得するメソッド
  def notification_message
    user.public_name + I18n.t('notifications.messages.comment_favorite')
  end
  
  # 通知クリック時のパス先指定のメソッド
  def notification_path
    post_path(comment.post.id)
  end
  
end
