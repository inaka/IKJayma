$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler/setup'

Bundler.require :default, ENV['RACK_ENV']

Dir[File.expand_path('../../model/*.rb', __FILE__)].each do |f|
  require f
end

Dir[File.expand_path('../../api/*.rb', __FILE__)].each do |f|
  require f
end

require 'goliath'
require 'api'
require 'ikjayma_app'

