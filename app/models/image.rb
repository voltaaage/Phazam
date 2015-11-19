class Image < ActiveRecord::Base
has_many :challenges

  def process_flickr_info(api_key,photo_id)
    general_info(api_key,photo_id)
    exif_data(api_key,photo_id)
  end

  def all_data_available
    focal_length != nil && exposure != nil && aperture != nil && iso_speed != nil
  end

  private

  def general_info(api_key,photo_id)
    info = flickr.photos.getInfo(photo_id: photo_id)
    update_attributes(
      photo_id: photo_id,
      title: info.title,
      medium_url: FlickRaw.url_m(info),
      large_url: FlickRaw.url_b(info)
    )
  end

  def exif_data(api_key,photo_id)
    begin
      exif = flickr.photos.getExif(api_key: api_key, photo_id: photo_id).exif
    rescue
      return nil
    end
    update_attributes(
      focal_length: parse_exif_data(exif,"Focal Length","clean"),
      exposure: parse_exif_data(exif,"Exposure","clean"),
      aperture: parse_exif_data(exif,"Aperture","clean"),
      iso_speed: parse_exif_data(exif,"ISO Speed","raw")
    )
  end

  def parse_exif_data(exif,label,content)
    exif_data = exif.select{|x| x["label"] == label}.first
    return nil if exif_data == nil
    exif_data.to_hash[content]
  end

end