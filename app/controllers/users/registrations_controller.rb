class Users::RegistrationsController < Devise::RegistrationsController
	before_filter :authenticate_user!, :only => [:wishes]
	respond_to :json

	# Register a new user
	def create
		user = User.new(params[:user])
		user.url = user.gravatar if user.gravatar

		if user.save
			user.ensure_authentication_token!

			response = {:success => true, :user => user.as_json(:only => [:id, :email, :authentication_token, :created_at, :updated_at, :url, :name, :age])}
			render :json => response, :status => 200
		else
			response = {:success => false, :errors => user.errors}
			render :json => response, :status => 500
		end
	end

	# Show a users wishes
	def wishes
		if current_user
		response = {
				:success => true,
				:wishes => current_user.wishes.as_json(:include => {:user => {:only => [:id, :email, :created_at, :updated_at, :url, :name, :age]}}, :methods => [:donated])
			}

		render :json => response, :status => 200
		else
			response = {:success => false, :error => "No such user"}
			render :json => response, :status => 404
		end
	end
end