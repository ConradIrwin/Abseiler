ENV["RACK_ENV"] ||= "development"

require "bundler"
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

module Abseiler
  autoload :App, "abseiler/app"

  autoload :RapletFactory,  "abseiler/raplet_factory"
  autoload :RapletNotFound, "abseiler/raplet_factory"

  autoload :Raplet,   "abseiler/raplet"
  autoload :NotFound, "abseiler/raplet"

  autoload :RapletConfig, "abseiler/raplet_config"

  autoload :Templater, "abseiler/templater"

  autoload :AssetPresenter,     "abseiler/presenters/asset_presenter"
  autoload :RapletPresenter,    "abseiler/presenters/raplet_presenter"
  autoload :MetadataPresenter,  "abseiler/presenters/metadata_presenter"
end
