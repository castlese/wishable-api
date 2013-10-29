class Wish < ActiveRecord::Base
  belongs_to :user
  has_many :wishes
  has_many :donations
  
  attr_accessible :cost, :title, :verified, :approval_key

  # Value donated so far
  def donated
  	donations.sum(&:amount)
  end
end
