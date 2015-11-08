class ChallengesController < ApplicationController
  include ChallengeHelper
  def index
    # Will eventually be Challenge.where{user_id: current_user}
    @challenges = Challenge.select{|x| x.user_id == current_user.id}
  end

  def new
    @challenge = Challenge.new
    @image = find_untested_image(current_user)
    @focal_lengths = focal_length_options(@image,4)
    @exposures = exposure_options(@image,4)
    @apertures = aperture_options(@image,4)
    @iso_speeds = iso_speed_options(@image,4)
    @exif_options = exif_options(@image,4)
  end

  def create
    challenge = Challenge.create(challenge_params)
    challenge.user_id = current_user.id if current_user
    if challenge.save
      image = challenge.image
      challenge.attribute_scoring(image)
      flash[:notice] = "Success - You have completed the challenge."
      redirect_to challenge
    else
      flash[:error] = "Something went wrong."
      redirect_to challenges_path
    end
  end

  def update
    challenge = Challenge.find(params[:id])
    challenge.update_attributes(challenge_params)
  end

  def show
    @challenge = Challenge.find(params[:id])
    @image = @challenge.image
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