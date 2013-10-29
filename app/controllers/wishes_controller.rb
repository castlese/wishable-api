class WishesController < ApplicationController
	respond_to :json
	before_filter :authenticate_user!, :only => [:create, :latest, :show]

	# Create a wish
	def create
		wish = Wish.new(params[:wish])
		wish.approval_key = SecureRandom.hex(16)

		if wish.save
			current_user.wishes << wish

			# Send a validation email for the admin to approve.
			AdminMailer.send_validation(current_user, wish).deliver

			response = {:success => true, :wish => wish.as_json(:include => {:user => {:only => [:id, :email, :created_at, :updated_at]}})}
			render :json => response, :status => 200
		else
			response = {:success => false, :errors => wish.errors}
			render :json => response, :status => 500
		end
	end

	# Approve a wish
	def approve
		wish = Wish.where(:approval_key => params[:approval_key]).first
		if wish
			wish.verified = true
			wish.save

			response = {:success => true}
			render :json => response, :status => 200
		else
			reponse = {:success => false, :error => "Invalid approval key"}
			render :json => response, :status => 500
		end
		
	end

	# Latest wishes
	def latest
		wishes = Wish.where(:verified => true).order("created_at desc")
		if wishes.count > 0
			response = {
				:success => true,
				:wishes => wishes.as_json(:include => {:user => {:only => [:id, :email, :created_at, :updated_at]}}, :methods => [:donated])
			}

			render :json => response, :status => 200
		else
			response = {:success => false, :error => "No valid wishes found"}
			render :json => response, :status => 404
		end
	end

	# Show a wish
	def show
		wish = Wish.where(:id => params[:id], :verified => true).first
		if wish
			response = {
				:success => true,
				:wish => wish.as_json(
					:include => {
						:user => {:only => [:id, :email, :created_at, :updated_at]},
						:donations => {:only => [:amount], :include => {:user => {:only => [:id, :email, :created_at, :updated_at]}}}
					}
				)
			}
			render :json => response, :status => 200
		else
			response = {:success => false, :error => "No valid wish found"}
			render :json => response, :status => 404
		end
	end
end
