module ImagesHelper
  def create_image_array
    # @id = '61558207@N04'
    @id = '55775945@N04'
    # @id = '102176013@N05'
    api_key = ENV['FLICKR_KEY']
    page_max = 12
    page_count = 0
    @images = []
    
    flickr.people.getPhotos(user_id: @id, api_key: api_key, per_page: page_max).each do |p|
      # Determine if image has been retrieved previously
      @image_id = Image.find{ |x| x.photo_id == p.id}

      if @image_id != nil || @image_id.all_data_available?
        @images << @image_id
      else                        
        @image = Image.new
        get_and_update_info(p.id,@image)
        get_and_update_exif_data(api_key,p.id,@image)

        @images << @image
      end

    end

    @images
  end

  private 

  def get_and_update_info(photo_id,image)
    info = flickr.photos.getInfo(photo_id: photo_id)
    title = info.title
    square_url = FlickRaw.url_s(info)
    medium_url = FlickRaw.url_m(info)
    original_url = FlickRaw.url_o(info)

    image.update_info(photo_id,title,square_url,medium_url,original_url)
  end

  def get_and_update_exif_data(api_key,flickr_photo_id,image)
    exif = flickr.photos.getExif(api_key: api_key, photo_id: flickr_photo_id).exif

    focal_length = parse_exif_data(exif,"Focal Length","clean")
    exposure = parse_exif_data(exif,"Exposure","clean")
    aperture = parse_exif_data(exif,"Aperture","clean")
    iso_speed = parse_exif_data(exif,"ISO Speed","raw")

    image.update_exif(focal_length,exposure,aperture,iso_speed)
    
  end

  def parse_exif_data(exif,label,content)
    exif_data = exif.select{|x| x["label"] == label}.first
    return nil if exif_data == nil
    exif_data.to_hash[content]
  end

  # def clean_content(exif_data)
  #   exif_data.to_hash["clean"]
  # end

  # def raw_content(exif_data)
  #   exif_data.to_hash["raw"]
  # end
end
