require 'performance/version'
require 'data_mapper'

module Performance
  # Your code goes here...
end

require File.expand_path('../config/initializers/config.rb', File.dirname(__FILE__))

DataMapper.setup(:default, "sqlite:///tmp/performance_#{CONFIG['hostname']}.sqlite3")
require 'performance/measurement'
DataMapper.finalize
DataMapper.auto_upgrade!

require 'performance/http_load'

