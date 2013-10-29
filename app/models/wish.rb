class Wish < ActiveRecord::Base
  belongs_to :user
  has_many :wish_videos
  attr_accessible :cost, :title, :verified, :wish_video_attributes

  accepts_nested_attributes_for :wish_videos, :allow_destroy => true



end
