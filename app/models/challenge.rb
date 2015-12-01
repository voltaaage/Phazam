class Challenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :image

  def attribute_scoring
    self.update_attributes(
      focal_length_correct: correct_focal_length_guess,
      exposure_correct: correct_exposure_guess,
      aperture_correct: correct_aperture_guess,
      iso_speed_correct: correct_iso_speed_guess,
      overall_score: overall_scoring
    )
  end

  def self.possible_focal_lengths
    (10..600).to_a.map!{|x| "#{x} mm"}
  end

  def self.possible_exposures
    [
      "30 sec",
      "25 sec",
      "20 sec",
      "15 sec",
      "13 sec",
      "10 sec",
      "8 sec",
      "6 sec",
      "5 sec",
      "4 sec",
      "3.2 sec",
      "2.5 sec",
      "2 sec",
      "1.6 sec",
      "1.3 sec",
      "1 sec",
      "0.8 sec",
      "0.6 sec",
      "0.5 sec",
      "0.4 sec",
      "0.3 sec",
      "0.25 sec (1/4)",
      "0.2 sec (1/5)",
      "0.167 sec (1/6)",
      "0.125 sec (1/8)",
      "0.1 sec (1/10)",
      "0.077 sec (1/13)",
      "1.15 sec (1/15)",
      "0.05 sec (1/20)",
      "0.04 sec (1/25)",
      "0.033 sec (1/30)",
      "0.025 sec (1/40)",
      "0.02 sec (1/50)",
      "0.0167 sec (1/60)",
      "0.0125 sec (1/80)",
      "0.01 sec (1/100)",
      "0.008 sec (1/125)",
      "0.00625 sec (1/160)",
      "0.005 sec (1/200)",
      "0.004 sec (1/250)",
      "0.003 sec (1/320)",
      "0.0025 sec (1/400)",
      "0.002 sec (1/500)",
      "0.0016 sec (1/640)",
      "0.00125 sec (1/800)",
      "0.001 sec (1/1000)",
      "0.0008 sec (1/1250)",
      "0.0006 sec (1/1600)",
      "0.0005 sec (1/2000)",
      "0.0004 sec (1/2500)",
      "0.0003 sec (1/3200)",
      "0.00025 sec (1/4000)"
    ]
  end

  def self.possible_apertures
    [1.2,1.4,1.8,2,2.2,2.5,2.8,3.2,3.5,4.0,4.5,5.0,5.6,6.3,7.1,8.0,9.0,10,11,13,14,16,18,20,22].map{|x| "f/#{x}"}
  end

  def self.possible_iso_speeds
    [50,100,200,400,800,1600,3200,6400,12800,25600,51200,65536]
  end

  def self.focal_length_options(image,number_of_choices)
    (possible_focal_lengths.sample(number_of_choices - 1) << image.focal_length).shuffle!
  end

  def self.exposure_options(image,number_of_choices)
    (possible_exposures.sample(number_of_choices - 1) << image.exposure).shuffle!
  end

  def self.aperture_options(image,number_of_choices)
    (possible_apertures.sample(number_of_choices - 1) << image.aperture).shuffle!
  end

  def self.iso_speed_options(image,number_of_choices)
    (possible_iso_speeds.sample(number_of_choices - 1) << image.iso_speed).shuffle!
  end

  def self.find_unchallenged_image(user)
    # Image.select{|img| img.all_data_available? && !Challenge.exists?(image_id: img.id, user_id: user.id)}.sample
    unchallenged = false
    until unchallenged
      image = Image.all.sample
      unchallenged = true if image.all_data_available && !Challenge.exists?(image_id: image.id, user_id: user.id) && image != nil
    end
    image
  end

  private

  def overall_scoring
    score = 0
    [correct_focal_length_guess,correct_exposure_guess,correct_aperture_guess,correct_iso_speed_guess].each do |attribute_correct|
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
