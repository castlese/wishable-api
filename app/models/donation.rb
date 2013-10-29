class Donation < ActiveRecord::Base
	belongs_to :user
  belongs_to :wish

  attr_accessible :amount, :user_id
end
