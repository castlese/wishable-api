class Donation < ActiveRecord::Base
  belongs_to :wish
  attr_accessible :amount
end
