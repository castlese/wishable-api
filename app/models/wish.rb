class Wish < ActiveRecord::Base
  belongs_to :user
  attr_accessible :cost, :title, :verified
end
