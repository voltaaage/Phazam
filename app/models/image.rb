class Image < ActiveRecord::Base
has_many :challenges

  def update_info(photo_id,title,square_url,medium_url,large_url,focal_length,exposure,aperture,iso_speed)
    all_data_available = (focal_length != nil && exposure != nil && aperture != nil && iso_speed != nil)
    self.update(
      photo_id: photo_id,
      title: title,
      square_url: square_url,
      medium_url: medium_url,
      large_url: large_url,
      focal_length: focal_length,
      exposure: exposure,
      aperture: aperture,
      iso_speed: iso_speed,
      all_data_available?: all_data_available
    )
  end

end
