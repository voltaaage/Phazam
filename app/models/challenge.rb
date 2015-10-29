class Challenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :image

  def scoring(image)
    self.focal_length_correct = (self.focal_length_guess == image.focal_length)
  end
end
