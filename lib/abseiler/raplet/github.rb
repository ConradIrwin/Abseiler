require 'faraday'
require "abseiler"

module Abseiler
  class Raplet::Github < Abseiler::Raplet
    short_name    :github
    description   "Shows some basic statistics from and a link to your contacts' Github Profiles."
    data_provider "Github Inc.", "http://github.com"

    def find_user!
      connection = Faraday.new(:url => "http://github.com")

      response = connection.get("/api/v2/json/user/email/#{@params[:email]}")
      if response.status == 200
        json_hash = JSON.parse(response.body)["user"]
        @user = User.new(json_hash)
      else
        raise NotFound
      end
    end

    class User
      attr_reader :login, :followers_count, :public_repo_count

      def initialize(json_hash)
        @login              = json_hash["login"]
        @followers_count    = json_hash["followers_count"]   || 0
        @public_repo_count  = json_hash["public_repo_count"] || 0

        @gravatar_id = json_hash["gravatar_id"]
      end

      def avatar_url
        "https://secure.gravatar.com/avatar/#{@gravatar_id}?s=140&amp;d=https://github.com%2Fimages%2Fgravatars%2Fgravatar-140.png"
      end

      def github_url
        "https://github.com/#{@login}"
      end
    end
  end
end
