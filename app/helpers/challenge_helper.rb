module ChallengeHelper

  def possible_focal_lengths
    (10..600).to_a
  end

  def possible_apertures
    [1.2,1.4,1.8,2,2.2,2.5,2.8,3.2,3.5,4.0,4.5,5.0,5.6,6.3,7.1,8.0,9.0,10,11,13,14,16,18,20,22]
  end

  def possible_exposures
    ["30","25","20","15","13","10","8","6","5","4","3.2","2.5","2","1.6","1.3","1","0.8","0.6","0.5","0.4","0.3","1/4","1/5","1/6","1/8","1/10","1/13","1/15","1/20","1/25","1/30","1/40","1/50","1/60","1/80","1/100","1/125","1/160","1/200","1/250","1/320","1/400","1/500","1/640","1/800","1/1000","1/1250","1/1600","1/2000","1/2500","1/3200","1/4000"]
  end

  def possible_iso_speeds
    [50,100,200,400,800,1600,3200,6400,12800,25600,51200,65536]
  end

  def focal_length_options(image,number_of_choices)
    options =[image.focal_length]
    (1..number_of_choices).each do 
      options << possible_focal_lengths.sample 
    end
    options.shuffle!
  end

  def exposure_options(image,number_of_choices)
    options =[image.exposure]
    (1..number_of_choices).each do 
      options << possible_exposures.sample 
    end
    options.shuffle!
  end

  def aperture_options(image,number_of_choices)
    options =[image.aperture]
    (1..number_of_choices).each do 
      options << possible_apertures.sample 
    end
    options.shuffle!
  end

  def iso_speed_options(image,number_of_choices)
    options =[image.iso_speed]
    (1..number_of_choices).each do 
      options << possible_iso_speeds.sample 
    end
    options.shuffle!
  end

end