class AddGeocodingColumnToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :address, :string, default: ""
    add_column :posts, :latitude, :float, default: 0
    add_column :posts, :longitude, :float, default: 0
  end
end
