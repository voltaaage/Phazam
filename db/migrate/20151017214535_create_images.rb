class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :photo_id
      t.string :title
      t.string :square_url
      t.string :medium_url
      t.string :large_url
      t.string :focal_length
      t.string :exposure
      t.string :aperture
      t.string :iso_speed
      t.boolean :all_data_available?, default: false
      
      t.timestamps null: false
    end
  end
end
