#!/usr/bin/env ruby
require 'rubygems'
require 'optparse'
require 'json'

begin
  require "performance"
rescue LoadError => e
  begin
    require_relative "./lib/performance.rb"
  rescue LoadError => e
    STDERR.puts "Install the missing library:\n\t \e[0;36m$\e[m \e[0;32mgem install performance\e[m"
    exit
  end
end

Performance::HttpLoad.exec
Performance::Measurement.to_csv_file
