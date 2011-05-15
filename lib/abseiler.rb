module Abseiler
  autoload :AbstractRaplet, "abseiler/abstract_raplet"
  autoload :Raplet,         "abseiler/raplet"

  RapletRegistry = {}

  def self.add(short_name, klass)
    RapletRegistry[short_name] = klass
  end
end