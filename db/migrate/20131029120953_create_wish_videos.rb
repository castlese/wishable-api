class CreateWishVideos < ActiveRecord::Migration
  def change
    create_table :wish_videos do |t|

      t.timestamps
    end
  end
end
