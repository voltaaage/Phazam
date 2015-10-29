class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|

      # Game Settings
      t.string :difficulty

      # Guessed Values
      t.string :focal_length_guess
      t.string :exposure_guess
      t.string :aperture_guess
      t.string :iso_speed_guess

      # Scoring
      t.boolean :focal_length_correct
      t.boolean :exposure_correct
      t.boolean :aperture_correct
      t.boolean :iso_speed_correct

      t.string :overall_score

      t.timestamps null: false
    end
  end
end
