require 'rails_helper'

describe ChallengeHelper do
  before do
    @image = Image.create(focal_length: '35mm', exposure: '1/100 sec', aperture: 2.0, iso_speed: 400)
  end

  describe 'focal length options' do
    it 'should return 4 options' do
      expect(focal_length_options(@image, 4).length).to eq 4
    end

    it 'should return 6 options' do
      expect(focal_length_options(@image, 6).length).to eq 6
    end

    it 'should contain the focal length of the image' do
      expect(focal_length_options(@image, 4).include? @image.focal_length).to be_truthy
    end
  end

  describe 'exposure options' do
    it 'should return 4 options' do
      expect(exposure_options(@image, 4).length).to eq 4
    end

    it 'should return 6 options' do
      expect(exposure_options(@image, 6).length).to eq 6
    end

    it 'should contain the focal length of the image' do
      expect(exposure_options(@image, 4).include? @image.exposure).to be_truthy
    end
  end

  describe 'aperture options' do
    it 'should return 4 options' do
      expect(aperture_options(@image, 4).length).to eq 4
    end

    it 'should return 6 options' do
      expect(aperture_options(@image, 6).length).to eq 6
    end

    it 'should contain the focal length of the image' do
      expect(aperture_options(@image, 4).include? @image.aperture).to be_truthy
    end
  end

  describe 'iso speed options' do
    it 'should return 4 options' do
      expect(iso_speed_options(@image, 4).length).to eq 4
    end

    it 'should return 6 options' do
      expect(iso_speed_options(@image, 6).length).to eq 6
    end

    it 'should contain the focal length of the image' do
      expect(iso_speed_options(@image, 4).include? @image.iso_speed).to be_truthy
    end
  end

  # describe 'find_unchallenged_image' do
  #   before do
  #     @user = User.new
  #     @image = Image.all.sample
  #     @challenge = Challenge.new(image: Image.first, user: @user)
  #   end

  #   it 'should find a unique image' do
  #     expect(find_unchallenged_image(@user)).not_to eql(@image)
  #     byebug
  #   end
  # end

end