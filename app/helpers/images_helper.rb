module ImagesHelper
  def extract
    id = "65079296@N06"
    puts "user ID: #{id}"

    flickr.photos.search(user_id: id, tags: 'best2014').each do |p|
      info = flickr.photos.getInfo(photo_id: p.id)

      title = info.title
      square_url = FlickRaw.user_s(info)
      original_url = FlickRaw.url_o(info)
      taken = info.dates.taken
      views = info.views
      tags = info.tags.map {|t| t.raw}

      puts "Photo #{title} with #{views} views and tags #{tags.join(",")}"
      puts "was taken on #{taken}, see it on #{square_url}"
    end
  end
end
