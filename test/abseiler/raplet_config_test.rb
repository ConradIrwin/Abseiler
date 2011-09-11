require File.expand_path(File.dirname(__FILE__)) + '/../test_helper.rb'

class OtherRaplet < Abseiler::Raplet
end

describe Abseiler::RapletConfig do
  include Abseiler

  after do
    RapletFactory.clear!
    TestRaplet.metadata.delete_if {|k,v| true }
    OtherRaplet.metadata.delete_if {|k,v| true }
  end

  it "should create a metadata hash" do
    h = TestRaplet.metadata
    h.must_be_instance_of Hash
  end

  it "should set short name" do
    TestRaplet.short_name :test

    TestRaplet.metadata[:short_name].must_equal :test
  end

  it "should set short name & name if no name set" do
    TestRaplet.short_name   :test
    OtherRaplet.raplet_name "Other Raplet"
    OtherRaplet.short_name  :other

    TestRaplet.metadata[:name].must_equal  "Test"
    OtherRaplet.metadata[:name].must_equal "Other Raplet"
  end

  it "should register the short name when setting it" do
    TestRaplet.short_name :test

    RapletFactory.raplet_class(:test).must_equal TestRaplet
  end

  it "should set singles" do
    TestRaplet.description "Foo Bar"
    TestRaplet.welcome_text "Welcome to Foo Bar"

    h = TestRaplet.metadata
    h[:description].must_equal  "Foo Bar"
    h[:welcome_text].must_equal "Welcome to Foo Bar"
  end

  it "should set doubles" do
    TestRaplet.provider      "Foo",         "http://example.com"
    TestRaplet.data_provider "Github Inc.", "http://github.com"

    h = TestRaplet.metadata
    h[:provider_name].must_equal "Foo"
    h[:provider_url].must_equal  "http://example.com"

    h[:data_provider_name].must_equal "Github Inc."
    h[:data_provider_url].must_equal  "http://github.com"
  end

  it "should not collide" do
    OtherRaplet.short_name :other
    OtherRaplet.description "Other Testicles!"

    OtherRaplet.metadata[:short_name].must_equal :other
    OtherRaplet.metadata[:description].must_equal "Other Testicles!"
  end

  # describe ".metadata_for" do
  #   it "should return a hash" do
  #     TestRaplet.short_name :test

  #     metadata = RapletConfig.metadata_for(TestRaplet)
  #     metadata.must_be_instance_of Hash
  #   end

  #   it "should have some default data in there" do
  #     TestRaplet.short_name :test

  #     metadata = RapletConfig.metadata_for(TestRaplet)
  #     metadata[:provider_name].must_equal("Lenary")
  #     metadata[:provider][:name].must_equal("Lenary")
  #     metadata[:provider_url].must_equal("http://lenary.co.uk/")
  #   end

  #   it "should allow default data to be overriden" do
  #     TestRaplet.short_name :test
  #     RapletConfig.metadata_for(TestRaplet)[:description].must_equal("")

  #     TestRaplet.description "Testicles!"
  #     RapletConfig.metadata_for(TestRaplet)[:description].must_equal("Testicles!")
  #   end
  # end
end
