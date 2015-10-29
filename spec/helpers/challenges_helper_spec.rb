require 'rails_helper'

describe ChallengeHelper do
  before do 
    @image = Image.create(focal_length: "35mm", exposure: "1/100 sec", aperture: 2.0, iso_speed: 400)
    @exif_hash = exif_options(@image,5)
  end

  describe "focal length options" do
    it "should return 4 options" do
      expect(focal_length_options(@image,4).length).to eq 4
    end

    it "should return 6 options" do
      expect(focal_length_options(@image,6).length).to eq 6
    end

    it "should contain the focal length of the image" do
      expect(focal_length_options(@image,4).include? @image.focal_length).to be_truthy
    end
  end

  describe "exposure options" do
    it "should return 4 options" do
      expect(exposure_options(@image,4).length).to eq 4
    end

    it "should return 6 options" do
      expect(exposure_options(@image,6).length).to eq 6
    end

    it "should contain the focal length of the image" do
      expect(exposure_options(@image,4).include? @image.exposure).to be_truthy
    end
  end

  describe "aperture options" do
    it "should return 4 options" do
      expect(aperture_options(@image,4).length).to eq 4
    end

    it "should return 6 options" do
      expect(aperture_options(@image,6).length).to eq 6
    end

    it "should contain the focal length of the image" do
      expect(aperture_options(@image,4).include? @image.aperture).to be_truthy
    end
  end

  describe "iso speed options" do
    it "should return 4 options" do
      expect(iso_speed_options(@image,4).length).to eq 4
    end

    it "should return 6 options" do
      expect(iso_speed_options(@image,6).length).to eq 6
    end

    it "should contain the focal length of the image" do
      expect(iso_speed_options(@image,4).include? @image.iso_speed).to be_truthy
    end
  end

  describe "exif_options" do

    it "should return 5 options for focal length" do
      expect(@exif_hash["focal_lengths"].length).to eq(5)
    end

    it "should return 5 options for exposure" do
      expect(@exif_hash["exposures"].length).to eq(5)
    end

    it "should return 5 options for aperture" do
      expect(@exif_hash["apertures"].length).to eq(5)
    end

    it "should return 5 options for iso speed" do
      expect(@exif_hash["iso_speeds"].length).to eq(5)
    end

    it "should return 1 option for iso speed" do
      exif_hash2 = exif_options(@image,1)
      expect(exif_hash2["iso_speeds"].length).to eq(1)
    end

    it "should contain the aperture of the image" do
      expect(@exif_hash["apertures"].include? @image.aperture).to be_truthy
    end
  end

end