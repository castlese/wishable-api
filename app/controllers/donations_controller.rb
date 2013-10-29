class DonationsController < ApplicationController
	respond_to :json
	before_filter :authenticate_user!

	# Add a donation to a wish
	def create
		wish = Wish.where(:id => params[:id]).first

		if wish
			donation = Donation.new(params[:donation])

			current_user.join_stripe! if !current_user.has_stripe_account?
			
			# Insert code here to process a card with the amount

			if donation.save
				wish.donations << donation
				current_user.donations << donation

				wish.funded = true if wish.donated >= wish.cost
				
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
