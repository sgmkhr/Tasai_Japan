class CreateRelatedRoomTags < ActiveRecord::Migration[6.1]
  def change
    create_table :related_room_tags do |t|
      t.references :counseling_room, null: false, foreign_key: true
      t.references :room_tag,        null: false, foreign_key: true

      t.timestamps
    end
  end
end
