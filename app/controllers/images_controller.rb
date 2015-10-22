class ImagesController < ApplicationController
  include ImagesHelper
  def index    
    # Hardcoded flickr IDs for testing
    # flicker_user_id = '55775945@N04' # mine
    # flicker_user_id = '61558207@N04' # Brad
    # flicker_user_id = '102176013@N05' # Peter

    api_key = ENV['FLICKR_KEY']
    api_secret = ENV['FLICKR_SECRET']
    per_page = 12


    flickr.access_token = "72157659750558870-8908998a3d2b8d02"
    flickr.access_secret = "a52e3cddaa02bced"
    
    login = flickr.test.login
    puts "You are now authenticated as #{login.username} with token #{flickr.access_token} and secret #{flickr.access_secret}"
    
    # @images = create_image_array_from_user(flicker_user_id,api_key,per_page)
    # @images = create_image_array_from_recently_uploaded(api_key,per_page)
    @images = create_image_array_from_interesting_photos(api_key,per_page)
  end

  def show
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])
    @image.update_attributes(image_params)
  end

  private

  def image_params
    params.require(:image).permit(:photo_id,:title,:square_url,:medium_url,:original_url,:focal_length,:exposure,:aperture,:iso_speed)
  end
end
