class ProfileView < ApplicationRecord
  include Notifiable

  belongs_to :viewer, class_name: 'User'
  belongs_to :viewed, class_name: 'User'
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  after_create do
    if viewed.passive_profile_views.count == ( 100 || 1000 || 10000 )
      create_notification(user_id: viewed_id) #current_user.idが引数でも良いかも
    end
  end
  
  def notification_message
    if self.count < 1000
      I18n.t('notifications.messages.profile_view.hundred')
    elsif self.count < 10000
      I18n.t('notifications.messages.profile_view.thousand')
    else
      I18n.t('notifications.messages.profile_view.ten_thousand')
    end
  end
  
  def notification_path
    user_path(viewed.canonical_name)
  end

end
