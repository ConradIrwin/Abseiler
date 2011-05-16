module Abseiler
  autoload :AbstractRaplet, "abseiler/abstract_raplet"
  autoload :Raplet,         "abseiler/raplet"
  autoload :RapletConfig,   "abseiler/raplet_config"

  mattr_accessor :registry
  self.registry = {}

  def self.add(short_name, klass)
    self.registry[short_name] = klass
    # do something with routes?
  end
end