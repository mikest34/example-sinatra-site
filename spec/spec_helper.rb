# spec/spec_helper.rb
require 'rack/test'
require 'rspec'
require 'capybara/rspec'

require File.expand_path '../../app.rb', __FILE__

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure do |config|
  config.include RSpecMixin 
  config.include Capybara::DSL
  config.include Rack::Test::Methods
  config.order = "random"
end

Capybara.app = DemoSite::App