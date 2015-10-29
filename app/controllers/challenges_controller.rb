class ChallengesController < ApplicationController
  include ChallengeHelper
  def index
    @challenges = Image.all.sample(36) # Challenge.all
  end

  def new
    @challenge = Challenge.new
    @image = Image.select{|x| x.all_data_available?}.sample
    @focal_length_options = focal_length_options(@image,4)
    @exposure_options = exposure_options(@image,4)
    @aperture_options = aperture_options(@image,4)
    @iso_speed_options = iso_speed_options(@image,4)
    @exif_options = exif_options(@image,4)
  end

  def create
    challenge = Challenge.create(challenge_params)
    if challenge.save
      image = Image.find(challenge.image_id)
      challenge.scoring(image)
      flash[:notice]="Success - You have completed the challenge."
      redirect_to challenge
    else
      flash[:error]="Something went wrong."
      redirect_to challenges_path
    end
  end

  def update 
    challenge = Challenge.find(params[:id])
    challenge.update_attributes(challenge_params)
  end

  def show
    @challenge = Challenge.find(params[:id])
    @image = Image.find(@challenge.image_id)
  end

  private

  def challenge_params
    params.permit(
      :difficulty,
      :focal_length_guess,
      :exposure_guess,
      :aperture_guess,
      :iso_speed_guess,
      :overall_score,
      :image_id)
  end
end