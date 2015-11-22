require 'rails_helper'

describe User do

  before do
    @user = User.create(name: 'Test User')
    @challenge1 = Challenge.create(
      user_id: @user,
      focal_length_correct: true,
      exposure_correct: true,
      aperture_correct: true,
      iso_speed_correct: true
    )
    @challenge2 = Challenge.create(
      user_id: @user,
      focal_length_correct: true,
      exposure_correct: true,
      aperture_correct: true,
      iso_speed_correct: false
    )
    @challenge3 = Challenge.create(
      user_id: @user,
      focal_length_correct: true,
      exposure_correct: true,
      aperture_correct: false,
      iso_speed_correct: false
    )
    @challenge4 = Challenge.create(
      user_id: @user,
      focal_length_correct: true,
      exposure_correct: false,
      aperture_correct: false,
      iso_speed_correct: false
    )
  end

  describe '#correct_focal_length_guesses' do
    it 'returns 4 for correct focal length guesses' do
      expect(@user.correct_focal_length_guesses).to eq(4)
    end
  end

  describe '#correct_exposure_guesses' do
    it 'returns 3 for correct exposure guesses' do
      expect(@user.correct_exposure_guesses).to eq(3)
    end
  end

  describe '#correct_aperture_guesses' do
    it 'returns 2 for correct aperture guesses' do
      expect(@user.correct_aperture_guesses).to eq(2)
    end
  end

  describe '#correct_iso_speed_guesses' do
    it 'returns 1 for correct iso speed guesses' do
      expect(@user.correct_iso_speed_guesses).to eq(1)
    end
  end

  describe '#total_correct_guesses' do
    it 'returns 10 for total number of correct guesses' do
      expect(@user.total_correct_guesses).to eq(10)
    end
  end

  describe '#total_guesses' do
    it 'returns 16 for total number of guesses' do
      expect(@user.total_guesses).to eq(16)
    end
  end

  describe '#total_number_of_challenges' do
    it 'returns 4 for the total number of challenges' do
      expect(@user.total_number_of_challenges).to eq(4)
    end
  end
end