class WishesController < ApplicationController
	respond_to :json
	before_filter :authenticate_user!

	# Create a wish
	def create
		wish = Wish.new(params[:wish])
		if wish.save
			current_user.wishes << wish
			response = {:success => true, :wish => wish.as_json}
			render :json => response, :status => 200
		else
			response = {:success => false, :errors => wish.errors}
			render :json => response, :status => 500
		end
	end
end
