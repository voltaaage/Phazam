class ChallengesController < ApplicationController
  include ImagesHelper
  def index
    @challenges = [Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample] # Challenge.all
  end

  def new
    @challenge = Challenge.new
    per_page = 12
    @images = create_image_array_from_interesting_photos(per_page)
    @image = @images.first
  end

  def create
    @challenge = Challenge.find(params[:id])
    @image = Image.find(params[:image_id])
    @challenge.save
  end

  def update 
    @chalenge = Challenge.find(params[:id])
    @challenge.update_attributes(challenge_params)
  end

  private

  def challenge_params
    require(:challenge_id).permit(:difficulty,:focal_length_accuracy,:exposure_accuracy,:aperture_accuracy,:iso_speed_accuracy,:overall_score)
  end
end