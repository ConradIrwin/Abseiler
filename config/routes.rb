Abseiler::Application.routes.draw do

  Abseiler::RapletRegistry.each do |short_name, klass|
    get "#{short_name}/info" => klass.action(:info)
  end

  get "github/info" => GithubRaplet.action(:info)
  # we need to revisit how this works.
end
