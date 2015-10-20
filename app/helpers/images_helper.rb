module ImagesHelper
  def create_image_array
    # Hardcoded flickr IDs for testing
    # @id = '55775945@N04' # mine
    @id = '61558207@N04' # Brad
    # @id = '102176013@N05' # Peter

    api_key = ENV['FLICKR_KEY']
    page_max = 12
    page_count = 0
    @images = []
    
    flickr.people.getPhotos(user_id: @id, api_key: api_key, per_page: page_max).each do |p|
      # Determine if image has been retrieved previously
      @image = Image.find{ |x| x.photo_id == p.id}
      @image = Image.new if @image == nil
      get_and_update_photo_info(p.id,api_key,@image) if !@image.all_data_available?
      @images << @image
    end

    @images
  end

  private 

  def get_and_update_photo_info(photo_id,api_key,image)
    # General info
    info = flickr.photos.getInfo(photo_id: photo_id)
    title = info.title
    square_url = FlickRaw.url_s(info)
    medium_url = FlickRaw.url_m(info)
    original_url = FlickRaw.url_o(info)

    # Exif info
    exif = flickr.photos.getExif(api_key: api_key, photo_id: photo_id).exif
    focal_length = parse_exif_data(exif,"Focal Length","clean")
    exposure = parse_exif_data(exif,"Exposure","clean")
    aperture = parse_exif_data(exif,"Aperture","clean")
    iso_speed = parse_exif_data(exif,"ISO Speed","raw")

    image.update_info(photo_id,title,square_url,medium_url,original_url,focal_length,exposure,aperture,iso_speed)
  end

  def parse_exif_data(exif,label,content)
    exif_data = exif.select{|x| x["label"] == label}.first
    return nil if exif_data == nil
    exif_data.to_hash[content]
  end

end
