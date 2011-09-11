source 'http://rubygems.org'

gem "sinatra", :require => false

gem "rack-contrib", :require => false,
                    :git => "https://github.com/rack/rack-contrib.git",
                    :branch => "master"


# Asset template engines
gem 'erubis'
gem 'sass'
gem 'coffee-script'

gem "faraday", "~> 0.7.4"

gem "rake"

group :development, :test do
  gem "shotgun"

  # Pretty printed test output
  gem 'turn', :require => false

  # Web Request Recording
  gem 'vcr', :require => false
  gem 'fakeweb', :require => false

  # Rack-Level testing
  gem 'rack-test', "~> 0.6.1"
end

