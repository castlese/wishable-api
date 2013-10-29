class AddLatLngToWish < ActiveRecord::Migration
  def change
  	add_column :wishes, :lat, :float
  	add_column :wishes, :lng, :float
  end
end
