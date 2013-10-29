class Users::RegistrationsController < Devise::RegistrationsController
	respond_to :json

	# Register a new user
	def create
		user = User.new(params[:user])
		if user.save
			user.ensure_authentication_token!

			response = {:success => true, :user => user.as_json(:only => [:id, :email, :authentication_token, :created_at, :updated_at])}
			render :json => response, :status => 200
		else
			response = {:success => false, :errors => user.errors}
			render :json => response, :status => 500
		end
	end
end