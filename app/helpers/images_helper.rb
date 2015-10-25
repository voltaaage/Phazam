module ImagesHelper
  def create_image_array_from_interesting_photos(per_page)
    images = []
    flickr.interestingness.getList(api_key: ENV['FLICKR_KEY'], per_page: per_page).each do |photo|
      image = process_image(ENV['FLICKR_KEY'],photo)
      images << image if image.all_data_available?
    end
    images
  end

  def create_image_array_from_recently_uploaded(per_page)
    images = []
    flickr.photos.getRecent(api_key: ENV['FLICKR_KEY'], per_page: per_page).each do |photo|
      image = process_image(ENV['FLICKR_KEY'],photo)
      images << image if image.all_data_available?
    end
    images
  end

  def create_image_array_from_user(flicker_user_id,per_page)
    images = []
    flickr.people.getPhotos(user_id: flicker_user_id, api_key: ENV['FLICKR_KEY'], per_page: per_page).each do |photo|
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
