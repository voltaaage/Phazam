class ChallengesController < ApplicationController
  include ImagesHelper
  def index
    @challenges = [Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample,Image.all.sample] # Challenge.all
  end

  def new
    @challenge = Challenge.new
    per_page = 12
    images = Images.all
    @image = @images.sample
    @focal_length_options = focal_length_options(@image,4)
    @exposure_options = exposure_options(@image,4)
    @aperture_options = aperture_options(@image,4)
    @iso_speed_options = iso_speed_options(@image,4)
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