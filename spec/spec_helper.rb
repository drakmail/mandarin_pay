$LOAD_PATH.unshift File.expand_path("..", __FILE__)
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "coveralls"
Coveralls.wear!

ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb", __FILE__)

require "rspec/rails"
require "mandarin_pay"
