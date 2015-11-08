module ImagesHelper

  # Helps prevent multiple api calls in the same day
  def flickr_images_from_today(per_page)
    images = Image.where({ created_at: (Time.now.midnight - 1.day)..Time.now.midnight, all_data_available?: true}).to_a
    if images.length == 0
      images = create_image_array_from_interesting_photos(per_page) #if images.length == 0
    end
    images
  end

  def create_image_array_from_interesting_photos(per_page)
    images = []
    flickr.interestingness.getList(api_key: ENV['FLICKR_KEY'], per_page: per_page).each do |photo|
      image = process_image(ENV['FLICKR_KEY'],photo)
      images << image if image.all_data_available?
    end
    images
  end

  private

  def process_image(api_key,photo)
    image = Image.find{ |x| x.photo_id == photo.id}
    image = Image.new if image == nil
    get_and_update_photo_info(api_key,photo.id,image) if !image.all_data_available?
    image
  end

  def get_and_update_photo_info(api_key,photo_id,image)
    # General info
    info = flickr.photos.getInfo(photo_id: photo_id)
    title = info.title
    square_url = FlickRaw.url_s(info)
    medium_url = FlickRaw.url_m(info)
    large_url = FlickRaw.url_b(info)

    # Original url is not consistently available based on previous experiences
    begin
      original_url = FlickRaw.url_o(info)
    rescue
      original_url = FlickRaw.url_b(info)
    end

    # Exif info
    begin
      exif = flickr.photos.getExif(api_key: api_key, photo_id: photo_id).exif
    rescue
      return nil
    end

    focal_length = parse_exif_data(exif,"Focal Length","clean")
    exposure = parse_exif_data(exif,"Exposure","clean")
    aperture = parse_exif_data(exif,"Aperture","clean")
    iso_speed = parse_exif_data(exif,"ISO Speed","raw")

    image.update_info(photo_id,title,square_url,medium_url,large_url,focal_length,exposure,aperture,iso_speed)
  end

  def parse_exif_data(exif,label,content)
    exif_data = exif.select{|x| x["label"] == label}.first
    return nil if exif_data == nil
    exif_data.to_hash[content]
  end

end
