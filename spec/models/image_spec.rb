require 'rails_helper'

describe Images do
  describe '#self.flickr_images_from_today' do
    it 'returns an array of images' do
      images = Image.flickr_images_from_today(25)
      expect(images).to be_an_instance_of(Array)
      expect(images.first).to be_an_instance_of(Image)
      expect(images.last).to be_an_instance_of(Image)
    end

    xit 'does not call #create_image_array_from_interesting_photos if existing images from today exist' do
      image = Image.new(created_at: Time.now.midnight + 1.hour)

      expect(Image.flickr_images_from_today(10)).not_to receive(:process_flickr_info)
    end
  end

  describe 'all_data_available' do
    it 'returns true when all attributes are available' do
      image = Image.new(focal_length: "35mm", exposure: "0.005 sec (1/200)", aperture: "f/2.0", iso_speed: "200")

      expect(image.all_data_available).to be_truthy
    end

    it 'returns false when one attribute is missing' do
      image = Image.new(focal_length: "35mm", exposure: "0.005 sec (1/200)", aperture: "f/2.0")

      expect(image.all_data_available).to be_falsy
    end

    it 'returns false when all attributes are missing' do
      image = Image.new

      expect(image.all_data_available).to be_falsy
    end
  end

  describe '#process_flickr_info' do
    xit '' do
    end
  end
end