module Abseiler
  class MetadataPresenter
    def initialize(metadata)
      @metadata = metadata
      @templater = Templater.new(metadata[:short_name])
    end

    def to_hash
      hash = default_hash.merge(@metadata)

      hash
    end

    def to_json
      to_hash.to_json
    end

    private

    def default_hash
      {
        description:    "",
        welcome_text:   "",
        icon_url:       "https://abseiler.heroku.com/a/#{@metadata[:short_name]}/icon.png",
        small_icon_url: "https://abseiler.heroku.com/a/#{@metadata[:short_name]}/small_icon.png",
        preview_url:    "https://abseiler.heroku.com/a/#{@metadata[:short_name]}/preview.png",
        provider_name:  "Lenary",
        provider_url:   "http://lenary.co.uk/",
        provider: {
          name: "Lenary",
          url:  "http://lenary.co.uk/",
        },
      }
    end
  end
end
