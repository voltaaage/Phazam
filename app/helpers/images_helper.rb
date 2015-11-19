module ImagesHelper

  # Helps prevent multiple api calls in the same day
  def flickr_images_from_today(per_page)
    images = Image.where({ created_at: (Time.now.midnight)..(Time.now.midnight + 1.day)}).to_a
    if images.length == 0
      images = create_image_array_from_interesting_photos(per_page) #if images.length == 0
    end
    images
  end

  private

  def create_image_array_from_interesting_photos(per_page)
    images = []
    flickr.interestingness.getList(api_key: ENV['FLICKR_KEY'], per_page: per_page).each do |photo|
      image = nil
      # image = Image.find{ |x| x.photo_id == photo.id}
      # image = Image.find{ |x| x.id == 99999 }
      image = process_image(ENV['FLICKR_KEY'],photo) if image == nil
      images << image if image.all_data_available
    end
    images
  end

  def process_image(api_key,photo)
    image = Image.new
    image.process_flickr_info(api_key,photo.id)
    image
  end
end