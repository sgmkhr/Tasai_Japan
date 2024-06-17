class ProfileView < ApplicationRecord
  include Notifiable

  belongs_to :viewer, class_name: 'User'
  belongs_to :viewed, class_name: 'User'
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  # データが作成されると直後に通知データも作成される
  after_create do
    if viewed.passive_profile_views.count == ( 100 || 1000 || 10000 )
      create_notification(user_id: viewed_id) #current_user.idが引数でも良いかも
    end
  end
  
  # 表示する通知メッセージを取得するメソッド
  def notification_message
    if viewed.passive_profile_views.count < 1000
      I18n.t('notifications.messages.profile_view.hundred')
    elsif viewed.passive_profile_views.count < 10000
      I18n.t('notifications.messages.profile_view.thousand')
    else
      I18n.t('notifications.messages.profile_view.ten_thousand')
    end
  end
  
  # 通知クリック時のパス先指定のメソッド
  def notification_path
    user_path(viewed.canonical_name)
  end

end
