class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      # Game Settings
      t.string :difficulty

      # Scoring
      t.string :focal_length_accuracy
      t.string :exposure_accuracy
      t.string :aperture_accuracy
      t.string :iso_speed_accuracy

      t.string :overall_score

      t.timestamps null: false
    end
  end
end
