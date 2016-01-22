# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

## Load images from Flickr every morning
every 1.day, at: '12:01 am' do
  rake "images:import_images"
end

## Purge database images every week to reduce database size
## Note: will break challenges models at this point
## but there's no point in letting my heroku server space get too big
every 1.week do
  rake "images:purge_images"
end