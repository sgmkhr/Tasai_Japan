class Chat < ApplicationRecord
  
  belongs_to :user
  belongs_to :chat_room
  
  validates :content, presence: true, length: { maximum: 5000 }
  validates :read,    presence: true 
  
  scope :latest, -> { order(created_at: :desc) }
  
  def get_sent_time_and_read
    if created_at == Time.current
      I18n.t('chats.sent_now')
    elsif created_at == Time.zone.now.all_day
      I18n.t('chats.sent_today') + self.created_at.strftime('%H:%M')
    elsif created_at == 1.day.ago.all_day
      I18n.t('chats.sent_yesterday') + self.created_at.strftime('%H:%M')
    elsif created_at == Date.today.year
      self.created_at.strftime('%m/%d %H:%M')
    else
      self.created_at.strftime('%Y/%m/%d %H:%M')
    end
  end
  
end
