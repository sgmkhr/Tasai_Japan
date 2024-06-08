class CreateOpinionFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :opinion_favorites do |t|
      t.references :user,    null: false, foreign_key: true
      t.references :opinion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
