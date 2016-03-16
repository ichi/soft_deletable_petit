require 'pry'
require 'pathname'
require 'rspec/its'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'soft_deletable_petit'

ROOT_PATH = Pathname.new(File.dirname __dir__)

RSpec.configure do |config|
end

Dir[ROOT_PATH.join('spec/support/**/*.rb')].each{|f| require f }
