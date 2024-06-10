class ChatRoom < ApplicationRecord

  has_many :entries, dependent: :destroy
  has_many :chats,   dependent: :destroy

  def read_chats(user)
    return unless self.chats.exists?
    return unless self.chats.where(read: false).exists?
    self.chats.where(user_id: user.id, read: false).each do |chat|
      chat.update(read: true)
    end
  end

end