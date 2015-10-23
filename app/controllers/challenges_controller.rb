class ChallengesController < ApplicationController
  include ImagesHelper
  def index
    @challenges = Challenge.all
  end

  def new
    @challenge = Challenge.new
    @image = 
  end

  def create
    @challenge = Challenge.new
    @challenge.save
  end
end