class ChatRoom < ApplicationRecord
  include Notifiable

  has_many :entries, dependent: :destroy
  has_many :chats,   dependent: :destroy
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  after_create do
    entries.each do |entry|
      unless entry.user_id == current_user.id
        create_notification(user_id: entry.user_id)
      end
    end
  end
  
  def notification_message
    entries.each do |entry|
      partner = entry.user unless entry.user_id == current_user.id
      return I18n.t('notifications.messages.chat_room')
    end
  end
  
  def notification_path
    entries.each do |entry|
      partner = entry.user unless entry.user_id == current_user.id
      return chat_path(partner.id)
    end
  end

  def read_chats(user)
    return unless self.chats.exists?
    return unless self.chats.where(read: false).exists?
    self.chats.where(user_id: user.id, read: false).each do |chat|
      chat.update(read: true)
    end
  end

end
