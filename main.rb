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

  alias_method(:require_without_derailed, :require)
  def require(path)
    raise "require"
  end

  alias_method(:require_relative_without_derailed, :require_relative)
  def require_relative(path)
    raise "require_relative"
  end

  alias_method(:load_without_derailed, :load)
  def load(path, wrap = false)
    raise "load"
  end
end

class Module
  alias_method(:autoload_without_derailed, :autoload)
  def autoload(const, path)
    raise "autoload"
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

