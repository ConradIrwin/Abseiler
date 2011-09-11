require File.expand_path(File.dirname(__FILE__)) + '/../test_helper.rb'

class HTTPTestRaplet < Abseiler::Raplet
  def self.metadata
    {short_name: "test"}
  end
end

describe Abseiler::App do
  include Abseiler

  before do
    RapletFactory.register(:http_test, HTTPTestRaplet)
    @session = new_session
  end

  after do
    RapletFactory.clear!
  end

  it "responds to root" do
    response = @session.get("")
    response.body.must_equal "Hey There!"
  end

  it "responds to metadata" do
    response = @session.get("/r/http_test.json", {show: "metadata"})
    json = json_parse(response)
    json["short_name"].must_equal "test"
    json["welcome_text"].must_match /Testy/
  end

  it "responds to raplet requests" do
    response = @session.get("/r/http_test.json", {email: "foo@example.com"})
    json_parse(response)["status"].must_equal 200
  end

  it "gives status 404 on bad raplet" do
    response = @session.get("/r/not_found.json", {show: "metadata"})
    response.status.must_equal 404
    json_parse(response)["message"].must_equal "Raplet Not Found"
  end

  it "should find the test image" do
    response = @session.get("/a/http_test/preview.png")
    response.status.must_equal 200
    response.content_type.must_equal "image/png"
  end
end
