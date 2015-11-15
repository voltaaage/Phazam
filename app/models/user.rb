class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :challenges

  def focal_length_accuracy

  end

  def exposure_accuracy

  end

  def aperture_accuracy

  end

  def iso_speed_accuracy

  end

  def overall_accuracy

  end
end
