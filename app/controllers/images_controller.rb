class ImagesController < ApplicationController
  def index    
    @id = "55775945@N04"
    api_key = ENV['FLICKR_KEY']
    page_count = 12
    @images = []
    
    flickr.people.getPhotos(user_id: @id, api_key: api_key, per_page: page_count).each do |p|
      # Gathering data from Flickraw
      info = flickr.photos.getInfo(photo_id: p.id)
      exif = flickr.photos.getExif(api_key: api_key, photo_id: p.id).exif

      image = {}

      image[:p_id]=p.id

      # info data
      image[:title] = info.title
      image[:square_url] = FlickRaw.url_s(info)
      image[:original_url] = FlickRaw.url_o(info)

      # exif data
      image[:focal_length] = exif.select{|x| x["label"] == "Focal Length"}.first.to_hash["clean"]
      image[:exposure] = exif.select{|x| x["label"] == "Exposure"}.first.to_hash["clean"]
      image[:aperture] = exif.select{|x| x["label"] == "Aperture"}.first.to_hash["clean"]
      image[:iso_speed] = exif.select{|x| x["label"] == "ISO Speed"}.first.to_hash["raw"]
      
      @images << image
    end
  end

  def show
    @image = Image.find(:id)
  end
end
