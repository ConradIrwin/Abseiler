require 'json'

module Abseiler
  class RapletNotFound < StandardError
  end

  class RapletFactory
    def self.register(symbol, klass)
      @@raplets ||= {}
      @@raplets[symbol.to_s] = klass
    end

    def self.new_raplet(params)
      klass = raplet_class(params.delete("raplet"))
      klass.new(params)
    end

    def self.raplet_class(name)
      @@raplets ||= {}
      @@raplets.fetch(name.to_s)
    rescue KeyError
      raise RapletNotFound
    end

    def self.clear!
      @@raplets = {}
    end

    # this could do with a little improvement. urls etc
    def self.to_json
      @@raplets ||= {}
      @@raplets.to_json
    end
  end
end
