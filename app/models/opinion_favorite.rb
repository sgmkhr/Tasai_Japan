class OpinionFavorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :opinion
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  validates :user_id, uniqueness: { scope: :opinion_id }
  
  after_create do
    create_notification(user_id: opinion.user_id)
  end
  
end
