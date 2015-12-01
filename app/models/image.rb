class Image < ActiveRecord::Base
  has_many :challenges

  # Helps prevent multiple api calls in the same day
  def self.flickr_images_from_today(per_page)
    images = Image.where({ created_at: (Time.now.midnight)..(Time.now.midnight + 1.day)}).to_a.select{|x| x.all_data_available}
    if images.length == 0
      images = Image.create_image_array_from_interesting_photos(per_page)
    end
    images
  end

  def all_data_available
    focal_length != nil && exposure != nil && aperture != nil && iso_speed != nil
  end

  private

  def self.create_image_array_from_interesting_photos(per_page)
    images = []
    flickr.interestingness.getList(api_key: ENV['FLICKR_KEY'], per_page: per_page).each do |photo|
      image = Image.find{ |x| x.photo_id == photo.id}
      image = process_image(ENV['FLICKR_KEY'],photo) if image == nil
      images << image if image.all_data_available
    end
    images
  end

  def self.process_image(api_key,photo)
    image = Image.new
    process_flickr_info(api_key,photo.id,image)
    image
  end

  def self.process_flickr_info(api_key,photo_id,image)
    general_info(api_key,photo_id,image)
    exif_data(api_key,photo_id,image)
  end

  def self.general_info(api_key,photo_id,image)
    info = flickr.photos.getInfo(photo_id: photo_id)
    image.update_attributes(
      photo_id: photo_id,
      title: info.title,
      medium_url: FlickRaw.url_m(info),
      large_url: FlickRaw.url_b(info)
    )
  end

  def self.exif_data(api_key,photo_id,image)
    begin
      exif = flickr.photos.getExif(api_key: api_key, photo_id: photo_id).exif
    rescue
      return nil
    end
    image.update_attributes(
      focal_length: parse_exif_data(exif,"Focal Length","clean"),
      exposure: parse_exif_data(exif,"Exposure","clean"),
      aperture: parse_exif_data(exif,"Aperture","clean"),
      iso_speed: parse_exif_data(exif,"ISO Speed","raw")
    )
  end

  def self.parse_exif_data(exif,label,content)
    exif_data = exif.select{|x| x["label"] == label}.first
    return nil if exif_data == nil
    exif_data.to_hash[content]
  end

end