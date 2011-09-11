#!/usr/bin/env rake
ENV["RACK_ENV"] ||= "development"

require "bundler"
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

namespace :test do
  Rake::TestTask.new(:raplets) do |t|
    t.libs << "test"
    t.test_files = FileList['test/raplets/*_test.rb']
    t.verbose = true
  end

  Rake::TestTask.new(:http) do |t|
    t.libs << "test"
    t.test_files = FileList['test/http/*_test.rb']
    t.verbose = true
  end

  Rake::TestTask.new(:abseiler) do |t|
    t.libs << "test"
    t.test_files = FileList['test/{abseiler,presenters}/*_test.rb']
    t.verbose = true
  end
end
