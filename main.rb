# frozen_string_literal: true

require 'bundler/setup'
require 'rails'
Bundler.require :default

module Dummy
  class Application < Rails::Application
    config.cache_classes = true
  end
end

Dummy::Application.initialize!

module Kernel
  module_function # rubocop:disable Style/ModuleFunction

  def require(path)
    raise "require"
  end
end

begin
  require 'rake'
rescue => e
  puts e.message
  puts "Worked AS EXPECTED !!!!!!!!!" if e.message == "require"
else
  raise "Did not work, expected an exception from our monkeypatch"
end

