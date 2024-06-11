class ProfileView < ApplicationRecord

  belongs_to :viewer, class_name: 'User'
  belongs_to :viewed, class_name: 'User'
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  after_create do
    if viewed.profile_wiews.count == ( 100 || 1000 || 10000 )
      create_notification(user_id: viewed_id)
    end
  end

end
