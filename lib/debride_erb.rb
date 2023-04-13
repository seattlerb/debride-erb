#!/usr/bin/ruby

require "debride"
require "erb"
require "erubi"

class Debride
  module Erb
    VERSION = "1.0.1"
  end

  ##
  # Process erb and parse the result. Returns the sexp of the parsed
  # ruby.

  def process_erb file
    erb = File.read file

    ruby = Erubi::Engine.new(erb, freeze_template_literals: false).src
    begin
      RubyParser.new.process ruby, file
    rescue => e
      warn ruby if option[:verbose]
      raise e
    end
  end
end
