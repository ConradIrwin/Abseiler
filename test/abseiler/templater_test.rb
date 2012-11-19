require File.expand_path(File.dirname(__FILE__)) + '/../test_helper.rb'

describe Abseiler::Templater do
  include Abseiler

  before do
    @templater = Templater.new("test")
    @root = Abseiler::App.root
  end

  describe "images" do
    it "tells us correctly if an image exists" do
      @templater.image_exists?("preview.png").must_equal true
      @templater.image_exists?("icon.png").must_equal false
    end

    it "tells us the correct path of an existing image" do
      path = @templater.image_path("preview.png")
      path.must_equal @root + "/raplets/test/images/preview.png"
    end

    it "gives us a nil path if the image doesn't exist" do
      path = @templater.image_path("icon.png")
      path.must_equal nil
    end
  end

  describe "assets" do

  end

  describe "templates" do

  end
end
