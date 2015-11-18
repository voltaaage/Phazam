class Challenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :image

  after_create :attribute_scoring

  def attribute_scoring
    self.update_attributes(
      focal_length_correct: correct_focal_length_guess,
      exposure_correct: correct_exposure_guess,
      aperture_correct: correct_aperture_guess,
      iso_speed_correct: correct_iso_speed_guess,
      overall_score: overall_scoring
    )
  end

  private

  def overall_scoring
    score = 0
    # score = score + 1 if self.focal_length_correct
    # score = score + 1 if self.exposure_correct
    # score = score + 1 if self.aperture_correct
    # score = score + 1 if self.iso_speed_correct
    # score

    [focal_length_correct,exposure_correct,aperture_correct,iso_speed_correct].each do |attribute_correct|
      score = score + 1 if attribute_correct
    end
    score
  end

  def correct_focal_length_guess
    self.focal_length_guess == self.image.focal_length
  end

  def correct_exposure_guess
    self.exposure_guess == self.image.exposure
  end

  def correct_aperture_guess
    self.aperture_guess == self.image.aperture
  end

  def correct_iso_speed_guess
    self.iso_speed_guess == self.image.iso_speed
  end

end
