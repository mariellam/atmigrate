require "thor"
require "yaml"
require "csv"

require "atmigrate/version"

require_relative 'atmigrate/generator'
require_relative 'atmigrate/test_file'

module Atmigrate
  class ThorCommands < Thor
    TestRailCsv::Generator.generate
  end
end
