require File.expand_path(File.dirname(__FILE__)) + '/../test_helper.rb'

class JSONRaplet < Abseiler::Raplet
end

describe Abseiler::Raplet do
  # TODO: test!
  # describe "JSON" do
  #   before do
  #     @raplet = JSONRaplet.new({})
  #   end

  #   it "should have status" do
  #     @raplet.to_hash.must_be :has_key?, "status"
  #     # this is ugly as hell. may switch to rspec soon
  #   end

  #   it "should have css" do
  #     @raplet.to_hash.must_be :has_key?, "css"
  #   end

  #   it "should have js" do
  #     @raplet.to_hash.must_be :has_key?, "js"
  #   end

  #   describe "simple" do
  #     it "should not have sections" do
  #       @raplet.to_hash.wont_be :has_key?, "sections"
  #     end

  #     it "should have html" do
  #       @raplet.to_hash.must_be :has_key?, "html"
  #     end
  #   end

  #   describe "collapsable" do
  #     it "should have sections" do
  #       json = @raplet.to_hash
  #       json.must_be :has_key?, "sections"
  #       json["sections"].must_be_instance_of Array
  #     end

  #     it "should have expanded html" do
  #       json = @raplet.to_hash
  #       json["sections"].first.must_be :has_key?, "expanded_html"
  #     end

  #     it "should have collapsed html" do
  #       json = @raplet.to_hash
  #       json["sections"].first.must_be :has_key?, "collapsed_html"
  #     end
  #   end
  # end
end


