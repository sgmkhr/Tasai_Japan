class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user,    null: false, foreign_key: true
      t.string :title,       null: false
      t.string :caption
      t.text :body
      t.integer :prefecture, null: false, default: 0

      t.timestamps
    end
  end
end
