namespace :images do
  desc "Deletes old images in the database"
  task purge_images: :environment do
    Image.where("created_at <= ?", Time.now - 14.days).destroy_all
  end

  desc "Imports images from Flickr's Interesting Photos stream"
  task import_images: :environment do
    Image.flickr_images_from_today(50)
  end
end