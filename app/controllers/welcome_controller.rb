class WelcomeController < ApplicationController
  def index
    @images = Image.select{|x| x.all_data_available}.sample(6)
  end
end
