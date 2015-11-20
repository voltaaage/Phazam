class ImagesController < ApplicationController
  def index
    @images = Image.flickr_images_from_today(48)
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
