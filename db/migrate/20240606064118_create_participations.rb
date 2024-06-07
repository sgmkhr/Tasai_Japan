class CreateParticipations < ActiveRecord::Migration[6.1]
  def change
    create_table :participations do |t|
      t.references :counseling_room, null: false, foreign_key: true
      t.references :user,            null: false, foreign_key: true
      t.boolean :status,             null: false, default: false

      t.timestamps
    end
  end
end
