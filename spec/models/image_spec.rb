require 'rails_helper'

describe Images do

  describe '#self.load_images' do
    it 'creates a new image in the DB' do
      expect{Image.load_images(1)}.to change{Image.all.count}.by(1)
    end

    it 'does not create a new image when it already exists' do
      Image.load_images(1)

      expect{Image.load_images(1)}.to change{Image.all.count}.by(0)
    end

  end # end load_images

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
  end # end all_data_available

end # end Images