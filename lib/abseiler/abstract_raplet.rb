class Abseiler::AbstractRaplet < ActionController::Metal
  abstract!

  MODULES = [
    AbstractController::AssetPaths,

    ActionController::Helpers,
    ActionController::HideActions,
    ActionController::Rendering,
    ActionController::Renderers,
    ActionController::RackDelegation,
    ActionController::Caching,
    ActionController::MimeResponds,

    ActionController::Cookies,
    ActionController::ForceSSL,

    AbstractController::Callbacks,
    ActionController::Instrumentation,
    ActionController::Rescue
  ]

  MODULES.each do |mod|
    include mod
  end

  ActionController::Renderers.add :json do |json, options|
    json = json.to_json(options) unless json.kind_of?(String)
    json = "#{options[:callback]}(#{json})" unless options[:callback].blank?
    self.content_type ||= Mime::JSON
    json
  end

  use_renderer :json

  ActiveSupport.run_load_hooks(:action_controller, self)
end
