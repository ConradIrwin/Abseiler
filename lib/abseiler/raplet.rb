require 'json'

require 'abseiler'

module Abseiler
  class NotFound < StandardError
  end

  class Raplet
    extend  RapletConfig

    attr_reader :status
    attr_reader :templater

    def initialize(params)
      @params = params
      @templater = Templater.new(self.class.metadata[:short_name])

      @status = 404
    end

    def find_user!
    end

    # def to_hash
    #   hash = {status: 200}
    #   hash[:css] = @templater.css
    #   hash[:js]  = @templater.js

    #   if @templater.collapsable?
    #     hash[:sections] = []
    #     hash[:sections] << {
    #       expanded_html:  @templater.template(:expanded),
    #       collapsed_html: @templater.template(:collapsed),
    #     }
    #   else
    #     hash[:html] = @templater.template(:expanded)
    #   end

    #   return hash
    # end

    # def to_json
    #   to_hash.to_json
    # end
  end
end
