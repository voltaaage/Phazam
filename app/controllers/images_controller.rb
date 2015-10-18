class ImagesController < ApplicationController
  include ImagesHelper
  def index    
    @images = create_image_array
  end

  def show
    @image = Image.find(:id)
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
