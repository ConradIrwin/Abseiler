module Abseiler
  module RapletConfig
    # def self.metadata_for(klass)
    #   metadata = klass.metadata
    #   {
    #     description:    "",
    #     welcome_text:   klass.template(:welcome).render,
    #     icon_url:       "https://abseiler.heroku.com/a/#{metadata[:short_name]}/icon.png",
    #     small_icon_url: "https://abseiler.heroku.com/a/#{metadata[:short_name]}/small_icon.png",
    #     preview_url:    "https://abseiler.heroku.com/a/#{metadata[:short_name]}/preview.png",
    #     provider_name:  "Lenary",
    #     provider_url:   "http://lenary.co.uk/",
    #     provider: {
    #       name: "Lenary",
    #       url:  "http://lenary.co.uk/",
    #     },
    #   }.merge(metadata)
    # end

    def metadata
      @metadata ||= {}
    end

    def short_name(sname)
      metadata[:short_name] = sname
      metadata[:name]     ||= sname.to_s.capitalize
      if defined? RapletFactory
        RapletFactory.register(sname, self)
      end
    end

    def raplet_name(name)
      metadata[:name] = name
    end

    %w(description welcome_text icon_url small_icon_url preview_url).each do |setting|
      module_eval(<<-EVAL, __FILE__, __LINE__)
        def #{setting}(new_value)
          metadata[:#{setting}] = new_value
        end
      EVAL
    end

    %w(provider data_provider).each do |setting|
      module_eval(<<-EVAL, __FILE__, __LINE__)
        def #{setting}(name, url)
          metadata[:#{setting}_name] = name
          metadata[:#{setting}_url]  = url

          metadata[:#{setting}]       ||= {}
          metadata[:#{setting}][:name]  = name
          metadata[:#{setting}][:url]   = url
        end
      EVAL
    end
  end
end
