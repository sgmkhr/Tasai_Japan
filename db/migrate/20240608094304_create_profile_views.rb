class CreateProfileViews < ActiveRecord::Migration[6.1]
  def change
    create_table :profile_views do |t|
      t.integer :viewer_id, null: false
      t.integer :viewed_id, null: false

      t.timestamps
    end
  end
end
