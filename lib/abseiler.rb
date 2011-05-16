module Abseiler
  autoload :AbstractRaplet, "abseiler/abstract_raplet"
  autoload :Raplet,         "abseiler/raplet"

  mattr_accessor :registry, :instance_reader => false
  self.registry = {}

  def self.add(short_name, klass)
    self.registry[short_name] = klass
    # do something with routes?
  end
end