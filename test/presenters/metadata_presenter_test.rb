require File.expand_path(File.dirname(__FILE__)) + '/../test_helper.rb'

describe Abseiler::MetadataPresenter do
  include Abseiler

  before do
    @presenter = MetadataPresenter.new({short_name: "test"})
  end

  it "should have a description" do
    @presenter.to_hash.must_be :has_key?, :description

    other_presenter = MetadataPresenter.new({short_name: "test", description: "Foo Bar"})
    other_presenter.to_hash[:description].must_equal "Foo Bar"
  end

  it "should come out as json" do
    @presenter.to_hash.must_be_instance_of Hash
    JSON.parse(@presenter.to_json).must_be_instance_of Hash
  end

  it "should render the welcome template if it exists" do
    @presenter.to_hash.must_be :has_key?, :welcome_text
    @presenter.to_hash[:welcome_text].must_match /Testy/
  end
end
