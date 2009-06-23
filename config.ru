require 'rubygems'
require 'sinatra'

Sinatra::Application.default_options.merge!({
	:run => false,
	:env => (ENV['RACK_ENV'] || 'production')
})

require 'infinite'
run Sinatra.application