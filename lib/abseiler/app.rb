require 'sinatra/base'

require 'abseiler'

module Abseiler
  class App < Sinatra::Base
    configure do
      set :root, File.expand_path('../..', File.dirname(__FILE__))
      disable :show_exceptions

      mime_type :json, 'application/json'
    end

    def self.app
      Rack::Builder.app do
        run App
      end
    end

    get "/" do
      "Hey There!"
    end

    get "/raplets.json" do
      content_type :json
      RapletFactory.to_json
    end

    get "/a/:raplet/*" do
      AssetPresenter.new(params["raplet"], params[:splat]).to_s
    end

    get "/r/:raplet.json" do
      content_type :json
      pass unless params[:show] == "metadata"

      raplet_klass = RapletFactory.raplet_class(params[:raplet])
      MetadataPresenter.new(raplet_klass.metadata).to_json
    end

    get "/r/:raplet.json" do
      content_type :json

      raplet = RapletFactory.new_raplet(params)
      raplet.find_user!
      RapletPresenter.new(raplet).to_json
    end

    error NotFound do
      status 404
      content_type :json
      {status: 404, message: "Not Found"}.to_json
    end

    error RapletNotFound do
      status 404
      content_type :json
      {status: 404, message: "Raplet Not Found"}.to_json
    end
  end
end

Dir[Abseiler::App.root+"/lib/abseiler/raplet/*.rb"].each do |raplet|
  load raplet
end
