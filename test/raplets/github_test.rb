require File.expand_path(File.dirname(__FILE__)) + '/../test_helper.rb'
require "abseiler/raplet/github"

describe Abseiler::Raplet::Github do
  include Abseiler

  describe ".find!" do
    it "should find the right github profile" do
      VCR.use_cassette("lenary") do
        raplet = Raplet::Github.new({email: "sam@lenary.co.uk"})

        user = raplet.find_user!
        user.must_be_instance_of Raplet::Github::User
      end
    end

    it "should error if there's no github profile" do
      VCR.use_cassette("nobody") do
        -> {
          raplet = Raplet::Github.new({email: "nobody@lenary.co.uk"})

          user = raplet.find_user!
        }.must_raise(NotFound)
      end
    end
  end

  describe Abseiler::Raplet::Github::User do
    it "should populate all the correct fields" do
      user_hash = {
        "public_repo_count"=>21,
        "followers_count"=>30,
        "login"=>"lenary"
      }
      user = Raplet::Github::User.new(user_hash)

      user.login.must_equal "lenary"
      user.followers_count.must_equal 30
      user.public_repo_count.must_equal 21
    end

    it "should create the right avatar url" do
      user_hash = {
        "gravatar_id"=>"334a587ef1901e2d48dfd15f90522496"
      }
      user = Raplet::Github::User.new(user_hash)

      user.avatar_url.must_match /334a587ef1901e2d48dfd15f90522496/
    end
  end
end


