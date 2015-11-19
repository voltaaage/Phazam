require 'rails_helper'

describe Images do

  describe '#process_flickr_info' do
    before do
      @photo_id = 22497337133
      @api_key = ENV['FLICKR_KEY']
      @image = Image.new
      @image.process_flickr_info(@api_key,@photo_id)
    end

    it 'returns an image' do
      expect(@image).to be_an_instance_of(Image)
    end

    it 'populates the image with general info' do
      expect(@image.photo_id).not_to be_nil
      expect(@image.title).not_to be_nil
      expect(@image.medium_url).not_to be_nil
      expect(@image.large_url).not_to be_nil
    end

    it 'populates the image with exif data' do
      expect(@image.focal_length).not_to be_nil
      expect(@image.exposure).not_to be_nil
      expect(@image.aperture).not_to be_nil
      expect(@image.iso_speed).not_to be_nil
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