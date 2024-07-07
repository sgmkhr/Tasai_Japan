class ChatRoom < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :chats,   dependent: :destroy

  has_one :notification, as: :notifiable, dependent: :destroy

  # 開いたチャットルーム内の相手からの未読メッセージを既読にするメソッド
  def read_chats(user)
    return unless self.chats.any?
    return unless self.chats.where(read: false).any?
    self.chats.where(user_id: user.id, read: false)&.update_all(read: true)
  end
end
