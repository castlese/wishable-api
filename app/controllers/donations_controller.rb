class DonationsController < ApplicationController
	respond_to :json
	before_filter :authenticate_user!

	# Add a donation to a wish
	def create
		wish = Wish.where(:id => params[:id]).first

		if wish
			donation = Donation.new(params[:donation])

			if donation.save
				wish.donations << donation
				response = {:success => true, :donation => donation.as_json(:include => {:wish => {:only  => [:id, :title, :verified, :cost]}})}
				render :json => response, :status => 200
			else
				response = {:success => false, :errors => donation.errors}
				render :json => response, :status => 500
			end

		else
			response = {:success => false, :error => "This is not a valid wish"}
			render :json => response, :status => 404
		end
	end
end
