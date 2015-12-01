class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @challenges = Challenge.select{|x| x.user_id == @user.id}
  end
end
