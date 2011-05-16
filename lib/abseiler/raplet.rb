class Abseiler::Raplet < Abseiler::AbstractRaplet
  respond_to :json

  before_filter :metadata
  before_filter :find_user

  cattr_accessor :metadata
  self.metadata = {}.with_indifferent_access

  class << self
    def short_name(sname=nil)
      if sname
        @sname = sname
        Abseiler.add(sname, self)
      else
        @sname
      end
    end

    [
      :name, :description, :icon_url, :small_icon_url, :preview_url,
      :provider_name, :provider_url, :data_provider_name, :data_provider_url
    ].each do |metadata_meth|
      module_eval(<<-EVAL, __FILE__, __LINE__)
        def #{metadata_meth}(new_#{metadata_meth}=nil)
          metadata_dsl(:"#{metadata_meth}", new_#{metadata_meth})
        end
      EVAL
    end

    [:provider, :data_provider].each do |quick_md_meth|
      module_eval(<<-EVAL, __FILE__, __LINE__)
        def #{quick_md_meth}(new_name=nil, new_url=nil)
          metadata_dsl(:"#{quick_md_meth}_name", new_name)
          metadata_dsl(:"#{quick_md_meth}_url",  new_url)
          return metadata_hash.select do |k,v|
            ["#{quick_md_meth}_name", "#{quick_md_meth}_url"].include? k
          end
        end
      EVAL
    end

    def metadata_hash
      self.metadata
    end

    protected
    def metadata_dsl(key, value=nil)
      if value == nil
        self.metadata[key]
      else
        self.metadata[key] = value
      end
    end
  end

  # the info action. this is all that is really used...
  def info
    respond_with({
      status:200,
      sections: [
        {
          expanded_html:  render_to_string(:expanded),
          collapsed_html: render_to_string(:collapsed),
        },
      ],
      css:  Rails.application.assets.find_asset("#{self.class.short_name}.css"),
      js:   Rails.application.assets.find_asset("#{self.class.short_name}.js")
    })
  end

  protected

  def metadata
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
      metadata_hash.merge!(welcome_text: render_to_string("#{short_name}/welcome"))
    end

    respond_with(metadata_hash) and return false
  end

  def find_user
    raise NotImplementedError, "Define find_user to set user params"
  end

  def short_name
    self.class.short_name
  end

  def not_found!
    respond_with({status: 404})
  end

end