require File.expand_path(File.dirname(__FILE__)) + '/../test_helper.rb'

describe Abseiler::RapletFactory do
  include Abseiler

  before do
    RapletFactory.register(:test, TestRaplet)
  end

  after do
    RapletFactory.clear!
  end

  it "can create a raplet" do
    raplet = RapletFactory.new_raplet({"raplet" => "test"})
    raplet.must_be_instance_of TestRaplet
  end

  it "can return the raplets class" do
    klass = RapletFactory.raplet_class("test")
    klass.must_equal TestRaplet
  end
end
