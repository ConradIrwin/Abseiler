class Abseiler::Raplet < Abseiler::AbstractRaplet
  include Abseiler::RapletConfig

  respond_to :json

  before_filter :show_metadata, :only => [:info]
  before_filter :find_user,     :only => [:info]


  # the info action. this is all that is really used...
  def raplet
    respond_with({
      status:200,
      sections: [
        {
          expanded_html:  raplet_template(:expanded),
          collapsed_html: raplet_template(:collapsed),
        },
      ],
      css:  raplet_asset("#{short_name}.css"),
      js:   raplet_asset("#{short_name}.js")
    })
  end

  protected

  def show_metadata
    return true unless params[:show] == "metadata"

    default_metadata_hash = {
      name:           short_name.capitalize,
      description:    "",
      welcome_text:   "",
      icon_url:       "https://abseiler.heroku.com/assets/#{short_name}/icon.png",
      small_icon_url: "https://abseiler.heroku.com/assets/#{short_name}/small_icon.png",
      preview_url:    "https://abseiler.heroku.com/assets/#{short_name}/preview.png",
      provider_name:  "Lenary",
      provider_url:   "http://lenary.co.uk/"
    }

    metadata_hash = default_metadata_hash.merge(self.class.metadata_hash)

    if lookup_context.template_exists?(:welcome, [short_name])
      metadata_hash.merge!(welcome_text: raplet_template(:welcome))
    end

    respond_with(metadata_hash) and return false
  end

  def find_user
    raise NotImplementedError, "Define find_user to set user params"
  end

  def not_found!
    respond_with({status: 404})
  end

  def raplet_template(symbol)
    render_to_string("#{short_name}/#{symbol}")
  end

  def raplet_asset(name)
    Rails.application.assets.find_asset(name)
  end
end