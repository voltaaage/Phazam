class Image < ActiveRecord::Base
  has_many :challenges

  def all_data_available
    focal_length != nil && exposure != nil && aperture != nil && iso_speed != nil
  end

  def self.load_images(per_page)
    flickr_interesting_images_api_call(per_page)
  end

  private

  def self.flickr_interesting_images_api_call(per_page)
    flickr.interestingness.getList(api_key: ENV['FLICKR_KEY'], per_page: per_page).each do |photo|
      create_image(ENV['FLICKR_KEY'],photo)
    end
  end

  def self.create_image(api_key,photo)
    retrieve_photo_info(api_key,photo.id) unless Image.exists?(photo_id: photo.id)
  end

  def self.retrieve_photo_info(api_key,photo_id)
    image = Image.new
    # need separate API calls for general info and exif data
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

  # Custom method to parse Flicker's JSON response
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