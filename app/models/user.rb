class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :challenges

  def correct_focal_length_guesses
    Challenge.where(user: self, focal_length_correct: true).count
  end

  def correct_exposure_guesses
    Challenge.where(user: self, exposure_correct: true).count
  end

  def correct_aperture_guesses
    Challenge.where(user: self, aperture_correct: true).count
  end

  def correct_iso_speed_guesses
    Challenge.where(user: self, iso_speed_correct: true).count
  end

  def total_correct_guesses
    correct_focal_length_guesses + correct_exposure_guesses + correct_aperture_guesses + correct_iso_speed_guesses
  end

  def total_guesses
    total_number_of_challenges * 4
  end

  def total_number_of_challenges
    Challenge.where(user: self).count
  end
end
