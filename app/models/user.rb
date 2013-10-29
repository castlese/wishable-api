class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  has_many :wishes
  has_many :donations
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :age, :url
  # attr_accessible :title, :body

  # Fetch a users gravatar
  def gravatar
    gravatar_id = Digest::MD5::hexdigest(email).downcase  
    "http://gravatar.com/avatar/#{gravatar_id}.png"  
  end

  # Stripe Account?
  def has_stripe_account?
    !stripe_id.nil?
  end

  def join_stripe!
    customer = Stripe::Customer.create(:email => email)
    stripe_id = customer.id
  end
end
