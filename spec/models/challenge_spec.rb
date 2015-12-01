require 'rails_helper'
describe Challenge do

  describe 'attribute_scoring' do
    before do
      @image = Image.create(
        focal_length: "35mm",
        exposure: "0.01 sec",
        aperture: "f/2.8",
        iso_speed: "300"
      )
      @correct_challenge = Challenge.create(
        image: @image,
        focal_length_guess: "35mm",
        exposure_guess: "0.01 sec",
        aperture_guess: "f/2.8",
        iso_speed_guess: "300"
      )
      @partially_correct_challenge = Challenge.create(
        image: @image,
        focal_length_guess: "35mm",
        exposure_guess: "0.03 sec", #incorrect
        aperture_guess: "f/4", #incorrect
        iso_speed_guess: "300"
      )
      @incorrect_challenge = Challenge.create(
        image: @image,
        focal_length_guess: "50mm", #incorrect
        exposure_guess: "0.03 sec", #incorrect
        aperture_guess: "f/4", #incorrect
        iso_speed_guess: "400" #incorrect
      )
    end

    it 'should update focal_length_correct to true if it is correct' do
      @correct_challenge.attribute_scoring

      expect(@correct_challenge.exposure_correct).to be_truthy
    end

    it 'should return a score of 4 for correct challenge' do
      @correct_challenge.attribute_scoring

      expect(@correct_challenge.overall_score).to eq 4
    end

    it 'should return a score of 2 for partially correct challenge' do
      @partially_correct_challenge.attribute_scoring

      expect(@partially_correct_challenge.overall_score).to eq 2
    end

    it 'should return a score of 0 for incorrect challenge' do
      @incorrect_challenge.attribute_scoring

      expect(@incorrect_challenge.overall_score).to eq 0
    end
  end

  before do
    @image = Image.create(focal_length: '35mm', exposure: '1/100 sec', aperture: 2.0, iso_speed: 400)
  end

  describe '#self.focal_length_options' do
    it 'should return 4 options' do
      expect(Challenge.focal_length_options(@image, 4).length).to eq 4
    end

    it 'should return 6 options' do
      expect(Challenge.focal_length_options(@image, 6).length).to eq 6
    end

    it 'should contain the focal length of the image' do
      expect(Challenge.focal_length_options(@image, 4).include? @image.focal_length).to be_truthy
    end
  end

  describe '#self.exposure_options' do
    it 'should return 4 options' do
      expect(Challenge.exposure_options(@image, 4).length).to eq 4
    end

    it 'should return 6 options' do
      expect(Challenge.exposure_options(@image, 6).length).to eq 6
    end

    it 'should contain the focal length of the image' do
      expect(Challenge.exposure_options(@image, 4).include? @image.exposure).to be_truthy
    end
  end

  describe '#self.aperture_options' do
    it 'should return 4 options' do
      expect(Challenge.aperture_options(@image, 4).length).to eq 4
    end

    it 'should return 6 options' do
      expect(Challenge.aperture_options(@image, 6).length).to eq 6
    end

    it 'should contain the focal length of the image' do
      expect(Challenge.aperture_options(@image, 4).include? @image.aperture).to be_truthy
    end
  end

  describe '#self.iso_speed_options' do
    it 'should return 4 options' do
      expect(Challenge.iso_speed_options(@image, 4).length).to eq 4
    end

    it 'should return 6 options' do
      expect(Challenge.iso_speed_options(@image, 6).length).to eq 6
    end

    it 'should contain the focal length of the image' do
      expect(Challenge.iso_speed_options(@image, 4).include? @image.iso_speed).to be_truthy
    end
  end
end