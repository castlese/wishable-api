class WishVideosController < ApplicationController

	respond_to :json
	before_filter :authenticate_user!, :only => [:create]

	# Create a wish
	def create

		wish_video= WishVideo.new
		wish_video.wish_id = params[:wish_video][:wish_id]
		wish_video.video = wish_video.decode_content_from_string(params[:wish_video][:video])


		if wish_video.save

			response = {:success => true, :wish_video => wish_video.as_json()}
			render :json => response, :status => 200
		else
			response = {:success => false, :errors => wish_video.errors}
			render :json => response, :status => 500
		end
	end
end
