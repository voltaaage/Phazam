require 'rails_helper'
describe Challenge do

  describe 'attribute_scoring' do
    before do
      @image = Image.new(
        focal_length: "35mm",
        exposure: "0.01 sec",
        aperture: "f/2.8",
        iso_speed: "300"
      )
      @correct_challenge = Challenge.new(
        image: @image,
        focal_length_guess: "35mm",
        exposure_guess: "0.01 sec",
        aperture_guess: "f/2.8",
        iso_speed_guess: "300"
      )
      @partially_correct_challenge = Challenge.new(
        image: @image,
        focal_length_guess: "35mm",
        exposure_guess: "0.03 sec", #incorrect
        aperture_guess: "f/4", #incorrect
        iso_speed_guess: "300"
      )
      @incorrect_challenge = Challenge.new(
        image: @image,
        focal_length_guess: "50mm", #incorrect
        exposure_guess: "0.03 sec", #incorrect
        aperture_guess: "f/4", #incorrect
        iso_speed_guess: "400" #incorrect
      )
    end

    it 'should call attribute_scoring after creation' do
      expect(@correct_challenge).to receive(:attribute_scoring)
      @correct_challenge.run_callbacks(:create) {true}
    end

    it 'should update focal_length_correct to true if it is correct' do
      @correct_challenge.attribute_scoring
      expect(@correct_challenge.focal_length_correct).to be_truthy
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
end