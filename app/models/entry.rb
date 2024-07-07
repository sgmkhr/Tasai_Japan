class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  # 対象entryに紐ずくチャットルームに存在する相手userを取得するメソッド
  def get_partner(user) # 引数は自分user
    chat_room.entries.each do |entry|
      return entry.user if entry.user_id != user.id
    end
  end

  # 対象entryに紐ずくチャットルーム内に未読チャットがあるか確認するメソッド
  def is_there_unread?(user) # 引数は相手user
    room = self.chat_room
    chats = user.chats.where(chat_room_id: room.id)
    if chats.exists?
      chats.exists?(read: false)
    else
      false
    end
  end

  # 対象entryに紐ずくチャットルーム内の最終チャットデータを取得するメソッド
  def get_last_chat(user)
    if chat_room.chats.present?
      chats = Chat.where(chat_room_id: self.chat_room_id).latest
      chats[0]
    else
      # このデータがないと、チャット一覧にルーム二つ以上且つチャット履歴のないルームがある際にエラーになる
      Chat.find_or_create_by!(chat_room_id: chat_room.id) do |chat|
        chat.user_id = user.id
        chat.content = I18n.t("chats.index.zero_chat_history")
        chat.created_at = self.chat_room.created_at
        chat.updated_at = self.chat_room.created_at
      end
    end
  end
end
