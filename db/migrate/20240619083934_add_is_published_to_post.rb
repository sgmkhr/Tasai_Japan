class AddIsPublishedToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :is_published, :boolean, null: false, default: true
  end
end
