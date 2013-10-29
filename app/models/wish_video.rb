class WishVideo < ActiveRecord::Base
  belongs_to :wish
  has_attached_file :video, 
    :url => ":s3_domain_url", :path => '/:class/:attachment/:id_partition/:style/:filename'
    attr_accessible :video_data


  def self.decode_content_from_string(video_data)
    data = StringIO.new(Base64.decode64(video_data))
    data.class.class_eval { attr_accessor :content_type, :original_filename }

    data.content_type = "image/jpg"
    data.original_filename = "video_#{SecureRandom.hex(32)}.jpg"

    data
  end


end
