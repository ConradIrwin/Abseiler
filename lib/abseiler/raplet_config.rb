module Abseiler::RapletConfig
  extend ActiveSupport::Concern

  included do
    cattr_accessor :metadata
    self.metadata = {}.with_indifferent_access
  end

  module ClassMethods

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

        def #{metadata_meth}=(new_#{metadata_meth})
          self.metadata[:"#{metadata_meth}"] = new_#{metadata_meth}
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

  def short_name
    self.class.short_name
  end
end