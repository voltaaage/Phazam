# Phazam

A Ruby on Rails Web Application that allows photographers to test their eye for settings used. Can you guess the shutter speed that was used? How about the focal length? Find out how you do in our challenge mode!

## Motivation

With photography becoming increasingly popular, we look to our favorite artists and photos for motivation to continue improving our skills. By looking at the settings used to create a shot, we as photographers can gain insight as to how we can go about re-creating our favorite images.

By evaluating focal length, we can assess how far the photographer was from their subject.

Shutter speed can provide some insight on whether the subject was moving fast or if the photo was done with a long exposure.

Aperture influences the depth of field in the photo. We can learn to adjust aperture based on what we want in focus.

ISO speed can tell us how much light was available and how sensitive the sensor needed to be.

The combination of these settings help photographers understand the way they work together to create a fantastic photo. My hope in creating this web application is to help others develop their photographic eye and continue creating fantastic photos.

## User Workflow + Screenshots

### View Photos

The 'View Photos' section is a gallery of images pulled in through the Flickr API. Hover over any photo to view its EXIF data: focal length, exposure, aperture, and ISO speed. Use this as a primer to help you start seeing these photos from a technical perspective.

![View Photos Section](/public/view_photos.png "View Photos")

![View Photos Section (Hover))](/public/view_photos_hover.png "View Photos (Hover)")

### Challenge

The Challenge section is where you test your skills! Users will be presented with one image and four options for each of the attributes.

![Challenge Section](/public/challenge.png "Challenge")

### User (Statistics + Past Challenges)

Go to your user page to see how you did on your past challenges and an overview of how accurate you are with the different attributes.

## Technical Details

Phazam leverages the FlickRaw gem to simplify the Flickr API. It firsts retrieves a set of images from Flickr's 'Interesting Photos of the Day' API. It then calls a separate API for each of the images in order to retrieve its associated data (EXIF attributes).

These images are then stored into the database to reduce API calls and retrieval times.

## Planned features

- Multiple images per challenge
- Enhanced statistics
- Revised algorithms for assessing a user's skill

## Contact

  Drop me a line if you're interested in talking about this project. 
