class CreateCounselingRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :counseling_rooms do |t|
      t.references :user,     null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :topic,        null: false
      t.text :detail,         null: false

      t.timestamps
    end
  end
end
