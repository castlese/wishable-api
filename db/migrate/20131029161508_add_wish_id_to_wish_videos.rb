class AddWishIdToWishVideos < ActiveRecord::Migration
  def change
  	add_column :wish_videos, :wish_id, :integer
  end
end
