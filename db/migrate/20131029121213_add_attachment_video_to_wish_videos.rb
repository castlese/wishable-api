class AddAttachmentVideoToWishVideos < ActiveRecord::Migration
  def self.up
    change_table :wish_videos do |t|
      t.attachment :video
    end
  end

  def self.down
    drop_attached_file :wish_videos, :video
  end
end
