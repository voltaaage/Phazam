class Challenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :image

  def attribute_scoring(image)
    self.update(
      focal_length_correct: (self.focal_length_guess == image.focal_length),
      exposure_correct: (self.exposure_guess == image.exposure),
      aperture_correct: (self.aperture_guess == image.aperture),
      iso_speed_correct: (self.iso_speed_guess == image.iso_speed)
      )
  end

  def overall_scoring
    score = 0
    if self.focal_length_correct
      score = score + 1
    elsif self.exposure_correct
      score = score + 1
    elsif self.aperture_correct
      score = score + 1
    elsif self.iso_speed_correct
      score = score + 1
    end
    score      
  end

end
