class Wish < ActiveRecord::Base
  belongs_to :user

  has_many :wish_videos
  has_many :wishes
  has_many :donations


  accepts_nested_attributes_for :wish_videos, :allow_destroy => true

  
  attr_accessible :cost, :title, :verified, :approval_key, :description, :wish_videos_attributes

  # Value donated so far
  def donated
  	donations.sum(&:amount)
  end

end
