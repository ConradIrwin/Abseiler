# require 'tilt'
# require 'dir'

module Abseiler
  class Templater
    def initialize(raplet_name)
      @raplet = raplet_name
    end

    def image_exists?(name)
      exists?(:image, name)
    end

    def image_path(name)
      path(:image, name) if image_exists?(name)
    end

    private

    def exists?(type, name)
      File.exists? path(type, name)
    end

    def path(type, name)
      Abseiler::App.root + "/raplets/#{@raplet}/#{type}s/#{name}"
    end

    # def javascript
    #   # raplet.js.coffee
    #   asset(:js)
    # end

    # def stylesheet
    #   # raplet.css.scss
    #   asset(:css)
    # end

    # def template(template)
    #   tmpl = self.class.template(template)
    #   tmpl.render(self)
    # end

    # def template_exists?(template)
    #   self.class.template_exists?(template)
    # end

    # private

    # def self.included(base)
    #   base.extend ClassMethods
    # end

    # module ClassMethods
    #   def template(template)
    #     if template_exists? template
    #       Tilt.new template_path(template)
    #     else
    #       FakeTemplate.new
    #     end
    #   end

    #   def template_exists?(template)
    #     File.exists? template_path(template)
    #   end

    #   private

    #   def template_path(template)
    #     Abseiler::App.root + "/raplets/#{metadata[:short_name]}/views/#{template}.erb"
    #   end
    # end
  end
end
