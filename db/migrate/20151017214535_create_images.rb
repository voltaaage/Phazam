class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :photo_id
      t.string :title
      t.string :medium_url
      t.string :large_url
      t.string :original_url
      t.string :focal_length
      t.string :exposure
      t.string :aperture
      t.string :iso_speed

      t.timestamps null: false
    end
  end
end
