class Entry < ApplicationRecord
  
  belongs_to :user
  belongs_to :chat_room
  
  # 対象entryに紐ずくチャットルームに存在する相手userを取得するメソッド
  def get_partner(user)#引数は自分user
    chat_room.entries.each do |entry|
      return entry.user if entry.user_id != user.id
    end
  end
  
  # 対象entryに紐ずくチャットルーム内に未読チャットがあるか確認するメソッド
  def is_there_unread?(user)#引数は相手user
    room = self.chat_room
    chats = user.chats.where(chat_room_id: room.id)
    if chats.exists?
      chats.exists?(read: false)
    else
      false
    end
  end
  
  # 対象entryに紐ずくチャットルーム内の最終チャットデータを取得するメソッド
  def get_last_chat
    if self.chat_room.chats.exists?
      chats = Chat.latest.where(chat_room_id: self.chat_room_id)
      return chats[0]
    end
  end
  
end
