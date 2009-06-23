require 'rubygems'
require 'sinatra'

require 'activesupport'
require 'fastercsv'

schedule = FCSV.read "./schedule.csv", :headers => true, :header_converters => :symbol, :converters => [:date, :numeric, (lambda { |f| ( f =~ /^\d+\// ? Date.parse(f) : f) })]

current_row = nil

schedule.each do |row|
  current_row = row
  break if row[:date] > Date.today
end

before do
end

get '/', :agent => /(?:iPhone|iPod)/ do
  @milestone, @page, @location = current_row[:date], current_row[:page], current_row[:location]
  erb :mobile
end

get '/' do
  # Get indiv vars for params
  @milestone, @page, @location = current_row[:date], current_row[:page], current_row[:location]
  erb :index
end