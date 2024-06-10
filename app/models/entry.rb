class Entry < ApplicationRecord
  
  belongs_to :user
  belongs_to :chat_room
  
  def get_partner(user)
    chat_room.entries.each do |entry|
      return entry.user if entry.user_id != user.id
    end
  end
  
  def is_there_unread?(user)
    room = self.chat_room
    chats = user.chats.where(chat_room_id: room.id)
    if chats.exists?
      chats.exists?(read: false)
    else
      false
    end
  end
  
  def get_last_chat
    if self.chat_room.chats.exists?
      chats = Chat.latest.where(chat_room_id: self.chat_room_id)
      return chats[0]
    end
  end
  
end
