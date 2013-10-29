class Users::SessionsController < Devise::SessionsController
	respond_to :json

	# Sign in a User
	def create
		if current_user
			current_user.ensure_authentication_token!

			response = {:success => true, :user => current_user.as_json(:only => [:id, :email, :authentication_token, :created_at, :updated_at, :url, :name, :age])}
			render :json => response, :status => 200;
		else
			warden.custom_failure!
			render :json=> {:success => false, :message => "Error with your login or password"}, :status=>401
		end
	end
end