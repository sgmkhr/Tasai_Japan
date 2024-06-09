class CreateRelatedPostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :related_post_tags do |t|
      t.references :post_tag, null: false, foreign_key: true
      t.references :post,     null: false, foreign_key: true

      t.timestamps
    end
  end
end
