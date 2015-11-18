class Image < ActiveRecord::Base
has_many :challenges

  def update_info(attributes)
    all_data_available = (attributes['focal_length'] != nil && attributes['exposure'] != nil && attributes['aperture'] != nil && attributes['iso_speed'] != nil)
    self.update(
      photo_id: attributes['photo_id'],
      title: attributes['title'],
      large_url: attributes['large_url'],
      focal_length: attributes['focal_length'],
      exposure: attributes['exposure'],
      aperture: attributes['aperture'],
      iso_speed: attributes['iso_speed'],
      all_data_available?: all_data_available
    )
  end



end
