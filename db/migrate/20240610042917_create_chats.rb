class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :user,      null: false, foreign_key: true
      t.references :chat_room, null: false, foreign_key: true
      t.text :content,         null: false
      t.boolean :read,         null: false, default: false

      t.timestamps
    end
  end
end
