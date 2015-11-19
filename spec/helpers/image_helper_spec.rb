require 'rails_helper'

describe ImagesHelper do
  describe '#flickr_images_from_today' do
    it 'returns an array of images' do
      images = flickr_images_from_today(10)

      expect(images).to be_an_instance_of(Array)
      expect(images.first).to be_an_instance_of(Image)
      expect(images.last).to be_an_instance_of(Image)
    end

    it 'does not call #create_image_array_from_interesting_photos if existing images from today exist' do
      image = Image.new(created_at: Time.now.midnight + 1.hour)
      expect(flickr_images_from_today(10)).not_to receive(:create_image_array_from_interesting_photos)
    end
  end
end