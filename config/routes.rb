Abseiler::Application.routes.draw do

  # we need to revisit how this works, because it currently doesn't
  Abseiler.registry.each do |short_name, klass|
    get "r/#{short_name}" => klass.action(:raplet)
  end

  get "r/github" => GithubRaplet.action(:raplet)

end
