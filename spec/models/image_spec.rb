require 'rails_helper'

describe Images do
  describe '#self.flickr_images_from_today' do
    it 'returns an array of images' do
      images = Image.flickr_images_from_today(25)
      expect(images).to be_an_instance_of(Array)
      expect(images.first).to be_an_instance_of(Image)
      expect(images.last).to be_an_instance_of(Image)
    end

    it 'does include images created after midnight' do
      image = Image.create(created_at: Time.now.midnight + 1.hour)

      expect(Image.flickr_images_from_today(10)).to eq([image])
    end

    it 'does not include images created before midnight' do
      image = Image.create(created_at: Time.now.midnight - 1.hour)

      expect(Image.flickr_images_from_today(10)).not_to include(image)
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
end