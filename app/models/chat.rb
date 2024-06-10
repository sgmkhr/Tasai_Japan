class Chat < ApplicationRecord
  
  belongs_to :user
  belongs_to :chat_room
  
  validates :content, presence: true, length: { maximum: 5000 }
  
  scope :latest, -> { order(created_at: :desc) }
  
  def get_sent_time_and_read
    if created_at.day == Time.current.day
      I18n.t('chats.sent_today') + self.created_at.strftime('%H:%M')
    elsif created_at.day == Time.current.yesterday.day
      I18n.t('chats.sent_yesterday') + self.created_at.strftime('%H:%M')
    elsif created_at.year == Time.current.year
      self.created_at.strftime('%m/%d %H:%M')
    else
      self.created_at.strftime('%Y/%m/%d %H:%M')
    end
  end
  
end
