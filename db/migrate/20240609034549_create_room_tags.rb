class CreateRoomTags < ActiveRecord::Migration[6.1]
  def change
    create_table :room_tags do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
