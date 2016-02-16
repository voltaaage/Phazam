class ImagesController < ApplicationController
  def index
    @images = Image.select{|x| x.all_data_available}.sample(30)
  end

  def show
    @image = Image.find(params[:id])
  end

  def load
    Image.flickr_images_from_today(72)
  end

  private

  def image_params
    params.require(:image).permit(
      :photo_id,
      :title,
      :square_url,
      :medium_url,
      :original_url,
      :focal_length,
      :exposure,
      :aperture,
      :iso_speed
    )
  end
end
