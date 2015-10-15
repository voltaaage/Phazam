class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def show
    @image = Image.find(:id)
  end
end
