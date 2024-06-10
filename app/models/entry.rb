class Entry < ApplicationRecord
  
  belongs_to :user
  belongs_to :chat_room
  
  def get_partner
    self.chat_room.entries do |entry|
      return entry.user if entry.user_id != current_user.id
    end
  end
  
  def is_there_unread?(user)
    room = self.chat_room
    user.chats.where(chat_room_id: room.id).includes?(read: false)
  end
  
  def get_last_chat
    if self.chat_room.chats.exist?
      chats = Chat.latest.where(chat_room_id: self.chat_room_id)
      return chats[0]
    end
  end
  
end
