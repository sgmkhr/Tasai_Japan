class ChatRoom < ApplicationRecord
  include Notifiable

  has_many :entries, dependent: :destroy
  has_many :chats,   dependent: :destroy
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  # データが作成されると直後に通知データも作成される
  after_create do
    entries.each do |entry|
      unless entry.user_id == current_user.id
        create_notification(user_id: entry.user_id)
      end
    end
  end
  
  # 表示する通知メッセージを取得するメソッド
  def notification_message
    entries.each do |entry|
      partner = entry.user unless entry.user_id == current_user.id
      return partner.public_name + I18n.t('notifications.messages.chat_room')
    end
  end
  
  # 通知クリック時のパス先指定のメソッド
  def notification_path
    entries.each do |entry|
      partner = entry.user unless entry.user_id == current_user.id
      return chat_path(partner.id)
    end
  end
  
  # 開いたチャットルーム内の相手からの未読メッセージを既読にするメソッド
  def read_chats(user)
    return unless self.chats.exists?
    return unless self.chats.where(read: false).exists?
    self.chats.where(user_id: user.id, read: false).each do |chat|
      chat.update(read: true)
    end
  end

end
