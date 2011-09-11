
ENV["RACK_ENV"] = "test"

require "minitest/spec"
require "minitest/mock"
require "rack/test"
require "vcr"
require 'turn'

require "abseiler"

VCR.config do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.stub_with :fakeweb
end

def new_session
  Rack::Test::Session.new(Abseiler::App.app)
end

class TestRaplet < Abseiler::Raplet
end

def json_parse(object)
  if object.respond_to? :body
    JSON.parse(object.body)
  else
    JSON.parse(object)
  end
end
