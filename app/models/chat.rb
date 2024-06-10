class Chat < ApplicationRecord
  
  belongs_to :user
  belongs_to :chat_room
  
  validates :content, presence: true, length: { maximum: 5000 }
  validates :read,    presence: true 
  
  scope :latest, -> { order(created_at: :desc) }
  
end
