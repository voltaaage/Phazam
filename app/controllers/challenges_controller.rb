class ChallengesController < ApplicationController
  def index
    # Will eventually be Challenge.where{user_id: current_user}
    @challenges = Challenge.all
  end

  def new
    @image = Challenge.find_unchallenged_image(current_user)
    @challenge = Challenge.new(image: @image)
    @focal_lengths = Challenge.focal_length_options(@image,4)
    @exposures = Challenge.exposure_options(@image,4)
    @apertures = Challenge.aperture_options(@image,4)
    @iso_speeds = Challenge.iso_speed_options(@image,4)
  end

  def create
    challenge = Challenge.create(challenge_params)
    challenge.user_id = current_user.id if current_user
    if challenge.save
      flash[:notice] = "Success - You have completed the challenge."
      redirect_to challenge
    else
      flash[:error] = "Something went wrong."
      redirect_to challenges
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